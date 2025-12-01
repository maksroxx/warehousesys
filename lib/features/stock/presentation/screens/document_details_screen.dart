// lib/features/stock/presentation/screens/document_details_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:warehousesys/core/theme/app_theme.dart';
import 'package:warehousesys/features/stock/data/models/counterparty.dart';
import 'package:warehousesys/features/stock/data/models/document_details.dart';
import 'package:warehousesys/features/stock/data/models/variant.dart';
import 'package:warehousesys/features/stock/presentation/providers/stock_providers.dart';
import 'package:intl/intl.dart';
import 'package:warehousesys/features/stock/presentation/screens/create_document_screen.dart';
import 'package:warehousesys/features/stock/presentation/widgets/add_item_from_stock_dialog.dart';

class DocumentDetailsScreen extends ConsumerStatefulWidget {
  final int documentId;
  const DocumentDetailsScreen({super.key, required this.documentId});

  @override
  ConsumerState<DocumentDetailsScreen> createState() =>
      _DocumentDetailsScreenState();
}

class _DocumentDetailsScreenState extends ConsumerState<DocumentDetailsScreen> {
  final _commentController = TextEditingController();
  final _counterpartySearchController = TextEditingController();
  final _counterpartyFocusNode = FocusNode();

  int? _selectedWarehouseId;
  Counterparty? _selectedCounterparty;
  List<DocumentItemRow> _items = [];

  bool _isLoading = false;
  bool _isInitialized = false;
  bool _showCounterpartyList = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _counterpartyFocusNode.addListener(() {
      if (_counterpartyFocusNode.hasFocus) {
        ref.read(counterpartyFilterProvider.notifier).update((state) => state.copyWith(search: null, offset: 0));
        setState(() => _showCounterpartyList = true);
      }
    });
  }

  @override
  void dispose() {
    _commentController.dispose();
    _counterpartySearchController.dispose();
    _counterpartyFocusNode.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _initializeState(DocumentDetailsDTO doc) {
    if (_isInitialized) return;

    _commentController.text = doc.comment ?? '';
    _selectedWarehouseId = doc.warehouseId;

    if (doc.counterpartyName != null) {
      final tempCounterparty = Counterparty(id: 0, name: doc.counterpartyName!);
      _selectedCounterparty = tempCounterparty;
      _counterpartySearchController.text = tempCounterparty.name;
    }

    _items = doc.items.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      return DocumentItemRow(
        index: index + 1,
        variantId: item.variantId,
        productName: item.productName,
        sku: item.variantSku,
        quantity: int.tryParse(item.quantity) ?? 0,
        price: double.tryParse(item.price ?? '0') ?? 0,
        unit: 'pcs',
      );
    }).toList();
    
    _isInitialized = true;
  }
  
  void _onCounterpartySearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      ref.read(counterpartyFilterProvider.notifier).update((state) => 
        state.copyWith(search: value.isEmpty ? null : value, offset: 0));
    });
  }

  Future<void> _showAddItemDialog() async {
    final List<InventoryItem>? selectedItems = await showDialog<List<InventoryItem>>(
      context: context,
      builder: (context) => const AddItemFromStockDialog(),
    );

    if (selectedItems != null && selectedItems.isNotEmpty) {
      setState(() {
        for (final item in selectedItems) {
          if (!_items.any((docItem) => docItem.variantId == item.id)) {
            _items.add(DocumentItemRow(
              index: _items.length + 1,
              variantId: item.id,
              productName: item.productName,
              sku: item.sku,
              unit: item.unitName,
              quantity: 1,
              price: 0,
            ));
          }
        }
      });
    }
  }

  void _removeItem(int index) {
     setState(() {
      _items.removeAt(index);
      for (int i = 0; i < _items.length; i++) {
        _items[i] = _items[i].copyWith(index: i + 1);
      }
    });
  }

  void _updateItem(int index, DocumentItemRow newItem) {
    setState(() => _items[index] = newItem);
  }

  Map<String, dynamic> _buildDocumentPayload(DocumentDetailsDTO originalDoc) {
    final itemsPayload = _items.map((item) {
      final itemMap = {
        'variant_id': item.variantId,
        'quantity': item.quantity.toString(),
      };
      if (originalDoc.type == 'INCOME') {
        itemMap['price'] = item.price.toStringAsFixed(2);
      }
      return itemMap;
    }).toList();

    return {
      'type': originalDoc.type,
      'warehouse_id': _selectedWarehouseId,
      'counterparty_id': _selectedCounterparty?.id,
      'comment': _commentController.text,
      'items': itemsPayload,
    };
  }

  Future<void> _updateAndSaveChanges(DocumentDetailsDTO doc) async {
    setState(() => _isLoading = true);
    try {
      final payload = _buildDocumentPayload(doc);
      await ref.read(stockRepositoryProvider).updateDocument(widget.documentId, payload);
      
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Draft updated successfully!'), backgroundColor: Colors.green));
      ref.invalidate(documentsProvider);
      ref.invalidate(documentDetailsProvider(widget.documentId));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error updating draft: $e'), backgroundColor: Colors.red));
    } finally {
      if(mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _postDocument() async {
    setState(() => _isLoading = true);
    try {
      final payload = _buildDocumentPayload(ref.read(documentDetailsProvider(widget.documentId)).value!);
      await ref.read(stockRepositoryProvider).updateDocument(widget.documentId, payload);
      
      await ref.read(stockRepositoryProvider).postDocument(widget.documentId);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Document posted successfully!'), backgroundColor: Colors.green));
      ref.invalidate(documentsProvider);
      ref.invalidate(inventoryProvider);
      ref.invalidate(documentDetailsProvider(widget.documentId));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error posting document: $e'), backgroundColor: Colors.red));
    } finally {
      if(mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _showDeleteConfirmationDialog(DocumentDetailsDTO doc) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content: Text('Are you sure you want to delete document #${doc.number}? This action cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() => _isLoading = true);
      try {
        await ref.read(stockRepositoryProvider).deleteDocument(doc.id);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Document deleted successfully'), backgroundColor: Colors.green));
        ref.invalidate(documentsProvider);
        Navigator.of(context).pop();
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error deleting document: $e'), backgroundColor: Colors.red));
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final documentAsync = ref.watch(documentDetailsProvider(widget.documentId));

    return Scaffold(
      backgroundColor: backgroundLightColor,
      body: documentAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error loading document:\n$err')),
        data: (doc) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && !_isInitialized) {
              setState(() => _initializeState(doc));
            }
          });
          
          final isDraft = doc.status == 'draft';
          
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: !_isInitialized 
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(context, doc, isDraft),
                      const SizedBox(height: 24),
                      _buildMainInfoSection(context, doc, isDraft),
                      const SizedBox(height: 24),
                      _buildItemsTable(context, isDraft),
                      const SizedBox(height: 24),
                      _buildFooter(context, doc, isDraft),
                    ],
                  ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, DocumentDetailsDTO doc, bool isDraft) {
    String docTypeName = doc.type == 'INCOME' ? 'Income Document' : 'Outcome Document';
    return Row(
      children: [
        IconButton(
          icon: Icon(PhosphorIconsRegular.arrowLeft),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Back',
        ),
        const SizedBox(width: 16),
        Text('$docTypeName #${doc.number}', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(width: 16),
        Chip(
          label: Text(doc.status.toUpperCase()),
          backgroundColor: doc.status == 'draft' ? Colors.orange.shade100 : Colors.green.shade100,
          labelStyle: TextStyle(
            color: doc.status == 'draft' ? Colors.orange.shade800 : Colors.green.shade800,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        if (isDraft)
          IconButton(
            icon: Icon(PhosphorIconsRegular.trash, color: Colors.red.shade600),
            onPressed: _isLoading ? null : () => _showDeleteConfirmationDialog(doc),
            tooltip: 'Delete Document',
          )
      ],
    );
  }

  // ✅ ИЗМЕНЕНИЕ: Полная замена на виджет из Create Screen
  Widget _buildMainInfoSection(BuildContext context, DocumentDetailsDTO doc, bool isDraft) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(12),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: AbsorbPointer(
        absorbing: !isDraft,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildWarehouseDropdown(isDraft),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: _buildCounterpartySearch(isDraft),
                ),
              ],
            ),
             const SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text( 'Comment', style: TextStyle( color: textDarkColor, fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _commentController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Add a comment...',
                    filled: true,
                    fillColor: isDraft ? Colors.white : backgroundLightColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWarehouseDropdown(bool isDraft) {
    final warehousesAsync = ref.watch(warehousesProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text( 'Warehouse *', style: TextStyle( color: textDarkColor, fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        warehousesAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => const Text('Error loading warehouses'),
          data: (warehouses) => DropdownButtonFormField<int>(
            value: _selectedWarehouseId,
            items: warehouses.map((warehouse) {
              return DropdownMenuItem<int>(
                value: warehouse.id,
                child: Text(warehouse.name),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedWarehouseId = value;
              });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: isDraft ? Colors.white : backgroundLightColor,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: borderColor)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: borderColor)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildCounterpartySearch(bool isDraft) {
    final counterpartiesState = ref.watch(counterpartiesProvider);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Counterparty *', style: TextStyle(color: textDarkColor, fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextFormField(
          controller: _counterpartySearchController,
          focusNode: _counterpartyFocusNode,
          onChanged: _onCounterpartySearchChanged,
          decoration: InputDecoration(
            hintText: 'Search for a counterparty...',
            filled: true,
            fillColor: isDraft ? Colors.white : backgroundLightColor,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: borderColor)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: borderColor)),
            suffixIcon: _selectedCounterparty != null && isDraft
              ? IconButton(
                  icon: Icon(PhosphorIconsRegular.x, size: 20, color: textGreyColor),
                  onPressed: () {
                    setState(() {
                      _selectedCounterparty = null;
                      _counterpartySearchController.clear();
                    });
                  },
                )
              : null,
          ),
        ),
        if (_showCounterpartyList && isDraft)
          Container(
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: borderColor),
              boxShadow: [BoxShadow(color: Colors.black.withAlpha(20), blurRadius: 8, offset: const Offset(0, 4))]
            ),
            constraints: const BoxConstraints(maxHeight: 300),
            child: _buildCounterpartyList(counterpartiesState),
          ),
      ],
    );
  }

  Widget _buildCounterpartyList(CounterpartyListState state) {
     final scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 50) {
        if (state.hasMore && !state.isLoadingNextPage) {
          ref.read(counterpartiesProvider.notifier).fetchNextPage();
        }
      }
    });

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: borderColor))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Select Counterparty', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: textDarkColor)),
              IconButton(
                icon: Icon(PhosphorIconsRegular.x, size: 16, color: textGreyColor),
                onPressed: () {
                  setState(() {
                    _showCounterpartyList = false;
                    _counterpartyFocusNode.unfocus();
                  });
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: state.isLoadingFirstPage
              ? const Center(child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator()))
              : state.error != null && state.counterparties.isEmpty
                  ? const Center(child: Padding(padding: EdgeInsets.all(16), child: Text('Error loading counterparties')))
                  : state.counterparties.isEmpty
                      ? const Padding(padding: EdgeInsets.all(16), child: Text('No counterparties found'))
                      : Scrollbar(
                          child: ListView.builder(
                            controller: scrollController,
                            shrinkWrap: true,
                            itemCount: state.counterparties.length + (state.hasMore ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == state.counterparties.length) {
                                return const Center(child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator()));
                              }
                              
                              final counterparty = state.counterparties[index];
                              return Container(
                                decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: borderColor))),
                                child: ListTile(
                                  title: Text(counterparty.name, style: const TextStyle(fontSize: 14)),
                                  subtitle: counterparty.phone != null ? Text(counterparty.phone!, style: const TextStyle(fontSize: 12)) : null,
                                  trailing: Icon(PhosphorIconsRegular.arrowRight, size: 16, color: textGreyColor),
                                  onTap: () {
                                    setState(() {
                                      _selectedCounterparty = counterparty;
                                      _counterpartySearchController.text = counterparty.name;
                                      _showCounterpartyList = false;
                                      _counterpartyFocusNode.unfocus();
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                        ),
        ),
      ],
    );
  }

  Widget _buildItemsTable(BuildContext context, bool isDraft) {
    return Container(
       padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Row(
              children: [
                _TableHeaderCell('№', flex: 1),
                _TableHeaderCell('ITEM', flex: 4),
                _TableHeaderCell('SKU', flex: 3),
                _TableHeaderCell('QUANTITY', flex: 2),
                _TableHeaderCell('UNIT', flex: 2),
                _TableHeaderCell('PRICE', flex: 2),
                _TableHeaderCell('SUM', flex: 2),
                _TableHeaderCell('', flex: 1),
              ],
            ),
          ),
          const Divider(height: 1, color: borderColor),
          if (_items.isEmpty)
            const Padding(padding: EdgeInsets.symmetric(vertical: 40), child: Text('No items in document'))
          else
            ..._items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return _DocumentItemRow(
                key: ValueKey("${item.variantId}-${index}"),
                item: item,
                isEditable: isDraft,
                onChanged: (newItem) => _updateItem(index, newItem),
                onRemove: () => _removeItem(index),
              );
            }),
          
          if(isDraft)
             Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton.icon(
                  onPressed: _showAddItemDialog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor.withOpacity(0.1),
                    foregroundColor: primaryColor,
                    elevation: 0,
                  ),
                  icon: Icon(PhosphorIconsRegular.listPlus),
                  label: const Text('Select Items'),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context, DocumentDetailsDTO doc, bool isDraft) {
    double totalSum = _items.fold(0, (sum, item) => sum + item.sum);
    final numberFormat = NumberFormat('#,##0.00', 'ru_RU');
    final isOrder = doc.type == 'ORDER';

    return Container(
       padding: const EdgeInsets.all(24),
       decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Total Sum: ${numberFormat.format(totalSum)} ₽', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          
          if (isDraft)
            // Кнопки для черновика (любого типа)
            Row(
              children: [
                OutlinedButton(onPressed: _isLoading ? null : () => _updateAndSaveChanges(doc), child: const Text('Save Changes')),
                const SizedBox(width: 12),
                FilledButton.icon(
                  icon: _isLoading ? const SizedBox.square(dimension: 18, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) : const SizedBox.shrink(),
                  label: _isLoading ? const Text('Processing...') : const Text('Post Document'),
                  onPressed: _isLoading ? null : _postDocument,
                ),
              ],
            )
          else if (!isDraft && isOrder)
            // Кнопка для проведенного ЗАКАЗА
            FilledButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CreateDocumentScreen(
                      documentType: 'OUTCOME',
                      baseDocumentId: doc.id,
                    ),
                  ),
                );
              },
              child: const Text('Create Shipment'),
            )
          else
            // Кнопка для всех остальных проведенных документов
            OutlinedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close')),
        ],
      ),
    );
  }
}

class _TableHeaderCell extends StatelessWidget {
  final String text;
  final int flex;

  const _TableHeaderCell(this.text, {this.flex = 1});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: textHeaderColor,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _DocumentItemRow extends StatefulWidget {
  final DocumentItemRow item;
  final bool isEditable;
  final Function(DocumentItemRow) onChanged;
  final VoidCallback onRemove;

  const _DocumentItemRow({
    super.key,
    required this.item,
    required this.isEditable,
    required this.onChanged,
    required this.onRemove,
  });

  @override
  State<_DocumentItemRow> createState() => _DocumentItemRowState();
}

class _DocumentItemRowState extends State<_DocumentItemRow> {
  late TextEditingController _quantityController;
  late TextEditingController _priceController;

   @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController(text: widget.item.quantity.toString());
    _priceController = TextEditingController(text: widget.item.price.toStringAsFixed(2));
  }

  @override
  void didUpdateWidget(covariant _DocumentItemRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.item.quantity.toString() != _quantityController.text) {
      _quantityController.text = widget.item.quantity.toString();
    }
    if (widget.item.price.toStringAsFixed(2) != _priceController.text) {
      _priceController.text = widget.item.price.toStringAsFixed(2);
    }
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _updateFromControllers() {
    final quantity = int.tryParse(_quantityController.text) ?? 0;
    final price = double.tryParse(_priceController.text) ?? 0.0;
    widget.onChanged(widget.item.copyWith(quantity: quantity, price: price));
  }
  
  InputDecoration _textFieldDecoration() {
    return InputDecoration(
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: borderColor),
      ),
      filled: true,
      fillColor: widget.isEditable ? Colors.white : backgroundLightColor.withOpacity(0.5),
    );
  }

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat('#,##0.00', 'ru_RU');
    final item = widget.item;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 1, child: Center(child: Text(item.index.toString(), style: const TextStyle(color: textGreyColor)))),
              const SizedBox(width: 8),
              Expanded(flex: 4, child: Text(item.productName, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w500))),
              const SizedBox(width: 8),
              Expanded(flex: 3, child: Text(item.sku, overflow: TextOverflow.ellipsis, style: const TextStyle(color: textGreyColor, fontSize: 13))),
              const SizedBox(width: 8),
              Expanded(flex: 2, child: TextFormField(
                controller: _quantityController,
                onChanged: (_) => _updateFromControllers(),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: _textFieldDecoration(),
                textAlign: TextAlign.right,
                readOnly: !widget.isEditable,
              )),
              const SizedBox(width: 8),
              Expanded(flex: 2, child: Center(child: Text(item.unit, style: const TextStyle(color: textGreyColor)))),
              const SizedBox(width: 8),
              Expanded(flex: 2, child: TextFormField(
                controller: _priceController,
                onChanged: (_) => _updateFromControllers(),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: _textFieldDecoration(),
                textAlign: TextAlign.right,
                readOnly: !widget.isEditable,
              )),
              const SizedBox(width: 8),
              Expanded(flex: 2, child: Text(numberFormat.format(item.sum), textAlign: TextAlign.right)),
              const SizedBox(width: 8),
              Expanded(flex: 1, child: Center(
                child: IconButton(
                  icon: Icon(PhosphorIconsRegular.trash, color: widget.isEditable ? Colors.red.shade400 : Colors.grey.shade300, size: 20),
                  onPressed: widget.isEditable ? widget.onRemove : null,
                  splashRadius: 20,
                ),
              )),
            ],
          ),
        ),
        const Divider(height: 1, color: borderColor),
      ],
    );
  }
}