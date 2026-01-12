import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:warehousesys/core/theme/app_theme.dart';
import 'package:warehousesys/features/stock/data/models/counterparty.dart';
import 'package:warehousesys/features/stock/data/models/filters.dart';
import 'package:warehousesys/features/stock/data/models/variant.dart';
import 'package:warehousesys/features/stock/presentation/providers/stock_providers.dart';
import 'package:intl/intl.dart';
import 'package:warehousesys/features/stock/presentation/screens/orders_screen.dart';
import 'package:warehousesys/features/stock/presentation/widgets/add_item_from_stock_dialog.dart';
import 'package:warehousesys/l10n/app_localizations.dart';

class CreateDocumentScreen extends ConsumerStatefulWidget {
  final String documentType;
  final int? baseDocumentId;

  const CreateDocumentScreen({
    super.key,
    required this.documentType,
    this.baseDocumentId,
  });

  @override
  ConsumerState<CreateDocumentScreen> createState() =>
      _CreateDocumentScreenState();
}

class _CreateDocumentScreenState extends ConsumerState<CreateDocumentScreen> {
  final _commentController = TextEditingController();
  final _counterpartySearchController = TextEditingController();
  final _counterpartyFocusNode = FocusNode();

  Timer? _debounce;
  int? _selectedWarehouseId;
  Counterparty? _selectedCounterparty;
  List<DocumentItemRow> _items = [];

  String? _warehouseError;
  String? _counterpartyError;
  String? _itemsError;

  bool _showCounterpartyList = false;
  bool _isLoading = false;
  bool _isInitializingFromBase = false;

  @override
  void initState() {
    super.initState();
    _counterpartyFocusNode.addListener(_onCounterpartyFocusChange);
    
    if (widget.baseDocumentId != null) {
      setState(() => _isInitializingFromBase = true);
      // Запускаем загрузку после построения первого кадра, чтобы был доступен context для локализации (если нужно)
      // Но так как текст ошибки внутри метода использует context, лучше вызывать так:
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _populateFromBaseDocument(widget.baseDocumentId!);
      });
    } else {
      _loadDefaultWarehouse();
    }
  }

  Future<void> _populateFromBaseDocument(int docId) async {
    try {
      final baseDoc = await ref.read(stockRepositoryProvider).getDocumentDetails(docId);
      
      if (!mounted) return;
      final l10n = AppLocalizations.of(context)!;

      setState(() {
        _selectedWarehouseId = baseDoc.warehouseId;
        // Локализованный комментарий "На основании..."
        _commentController.text = l10n.basedOnDocument(baseDoc.number);
        
        if (baseDoc.counterpartyName != null) {
          final tempCp = Counterparty(id: 0, name: baseDoc.counterpartyName!);
          _selectedCounterparty = tempCp;
          _counterpartySearchController.text = tempCp.name;
        }

        _items = baseDoc.items.asMap().entries.map((entry) {
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

        _isInitializingFromBase = false;
      });

    } catch (e) {
      if (!mounted) return;
      final l10n = AppLocalizations.of(context)!;
      setState(() => _isInitializingFromBase = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.errorLoadingBaseDocument(e)), backgroundColor: Colors.red));
    }
  }
  
  @override
  void dispose() {
    _debounce?.cancel();
    _commentController.dispose();
    _counterpartySearchController.dispose();
    _counterpartyFocusNode.dispose();
    super.dispose();
  }

  void _onCounterpartyFocusChange() {
    if (_counterpartyFocusNode.hasFocus) {
      setState(() {
        _showCounterpartyList = true;
      });
    }
  }

  void _loadDefaultWarehouse() async {
    final warehouses = await ref.read(stockRepositoryProvider).getWarehouses();
    if (warehouses.isNotEmpty) {
      setState(() {
        _selectedWarehouseId = warehouses.first.id;
      });
    }
  }

  void _onCounterpartySearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      ref
          .read(counterpartyFilterProvider.notifier)
          .update((state) => state.copyWith(
                search: value.isEmpty ? null : value,
                offset: 0,
              ));
    });
  }

  Future<void> _showAddItemDialog() async {
    final List<InventoryItem>? selectedItems =
        await showDialog<List<InventoryItem>>(
      context: context,
      builder: (context) => const AddItemFromStockDialog(),
    );

    if (selectedItems != null && selectedItems.isNotEmpty) {
      setState(() {
        for (final item in selectedItems) {
          if (!_items.any((docItem) => docItem.variantId == item.id)) {
            _items.add(
              DocumentItemRow(
                index: _items.length + 1,
                variantId: item.id,
                productName: item.productName,
                sku: item.sku,
                unit: item.unitName,
                quantity: 1,
                price: 0,
              ),
            );
          }
        }
        if (_items.isNotEmpty) {
          _itemsError = null;
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
    setState(() {
      _items[index] = newItem;
    });
  }

  bool _validateForm() {
    final l10n = AppLocalizations.of(context)!;
    bool isValid = true;
    setState(() {
      _warehouseError =
          _selectedWarehouseId == null ? l10n.selectWarehouseError : null;
      _counterpartyError =
          _selectedCounterparty == null ? l10n.selectCounterpartyError : null;
      _itemsError = _items.isEmpty ? l10n.itemsError : null;

      if (_warehouseError != null ||
          _counterpartyError != null ||
          _itemsError != null) {
        isValid = false;
      } else {
        for (final item in _items) {
          if (item.quantity <= 0) {
            _itemsError = l10n.quantityError;
            isValid = false;
            break;
          }
        }
      }
    });
    return isValid;
  }
  
  Map<String, dynamic> _buildDocumentPayload() {
    final itemsPayload = _items.map((item) {
      final itemMap = {
        'variant_id': item.variantId,
        'quantity': item.quantity.toString(),
      };
      if (widget.documentType == 'INCOME') {
        itemMap['price'] = item.price.toStringAsFixed(2);
      }
      return itemMap;
    }).toList();

    return {
      'type': widget.documentType,
      'base_document_id': widget.baseDocumentId,
      'warehouse_id': _selectedWarehouseId,
      'counterparty_id': _selectedCounterparty?.id,
      'comment': _commentController.text,
      'items': itemsPayload,
    };
  }

  Future<void> _saveDocument() async {
    if (!_validateForm()) return;

    setState(() => _isLoading = true);
    final l10n = AppLocalizations.of(context)!;
    
    try {
      final payload = _buildDocumentPayload();
      await ref.read(stockRepositoryProvider).createDocument(payload);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.documentSavedDraft),
          backgroundColor: Colors.green,
        ),
      );
      
      ref.invalidate(documentsProvider);
      ref.invalidate(ordersProvider);
      Navigator.of(context).pop();

    } catch (e) {
       if (!mounted) return;
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.saveError(e)),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if(mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _postAndClose() async {
    if (!_validateForm()) return;

    setState(() => _isLoading = true);
    final l10n = AppLocalizations.of(context)!;

    try {
      final payload = _buildDocumentPayload();
      final createdDocument = await ref.read(stockRepositoryProvider).createDocument(payload);
      
      await ref.read(stockRepositoryProvider).postDocument(createdDocument.id);
      
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.documentPostedSuccess),
          backgroundColor: Colors.green,
        ),
      );
      
      ref.invalidate(ordersProvider);
      ref.invalidate(documentsProvider);
      ref.invalidate(inventoryProvider);
      
      Navigator.of(context).pop();

    } catch (e) {
       if (!mounted) return;
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.postError(e)),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
       if(mounted) setState(() => _isLoading = false);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final double totalSum = _items.fold(0, (sum, item) => sum + item.sum);
    final l10n = AppLocalizations.of(context)!;

    if (_isInitializingFromBase) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(l10n.loadingBaseDocument),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundLightColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, l10n),
              const SizedBox(height: 24),
              _buildWarehouseCounterpartySection(context, l10n),
              const SizedBox(height: 24),
              _buildCommentSection(context, l10n),
              const SizedBox(height: 24),
              _buildItemsTable(context, textTheme, l10n),
              const SizedBox(height: 24),
              _buildFooter(context, totalSum, l10n),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations l10n) {
     return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          icon: Icon(PhosphorIconsRegular.arrowLeft, size: 24),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Back', // Можно тоже добавить в локализацию, если критично
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.documentType == 'INCOME' 
                  ? l10n.createIncomeDocument 
                  : l10n.createOutcomeDocument,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWarehouseCounterpartySection(BuildContext context, AppLocalizations l10n) {
    final warehousesAsync = ref.watch(warehousesProvider);
    
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
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildWarehouseDropdown(warehousesAsync, l10n),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildCounterpartySearch(l10n),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWarehouseDropdown(AsyncValue<List<Warehouse>> warehousesAsync, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${l10n.warehouseLabel} *',
          style: const TextStyle(
            color: textDarkColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        warehousesAsync.when(
          loading: () => Container(
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: borderColor),
            ),
            child: const Center(child: CircularProgressIndicator()),
          ),
          error: (error, stack) => Container(
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.red),
            ),
            child: Center(child: Text(l10n.errorLoadingWarehouses)),
          ),
          data: (warehouses) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _warehouseError != null ? Colors.red : borderColor,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: _selectedWarehouseId,
                    isExpanded: true,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    items: warehouses.map((warehouse) {
                      return DropdownMenuItem<int>(
                        value: warehouse.id,
                        child: Text(
                          warehouse.name,
                          style: const TextStyle(
                            fontSize: 16,
                            color: textDarkColor,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedWarehouseId = value;
                        _warehouseError = null;
                      });
                    },
                  ),
                ),
              ),
              if (_warehouseError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    _warehouseError!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCounterpartySearch(AppLocalizations l10n) {
    final counterpartiesState = ref.watch(counterpartiesProvider);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${l10n.counterpartyLabel} *',
          style: const TextStyle(
            color: textDarkColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _counterpartySearchController,
          focusNode: _counterpartyFocusNode,
          onChanged: _onCounterpartySearchChanged,
          onTap: () {
            setState(() {
              _showCounterpartyList = true;
            });
          },
          decoration: InputDecoration(
            hintText: l10n.searchCounterpartyHint,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: _counterpartyError != null ? Colors.red : borderColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: _counterpartyError != null ? Colors.red : borderColor,
              ),
            ),
            suffixIcon: _selectedCounterparty != null
                ? IconButton(
                    icon: Icon(PhosphorIconsRegular.x, size: 20, color: textGreyColor),
                    onPressed: () {
                      setState(() {
                        _selectedCounterparty = null;
                        _counterpartySearchController.clear();
                        _counterpartyError = null;
                      });
                    },
                  )
                : null,
          ),
        ),
        if (_counterpartyError != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              _counterpartyError!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
        if (_showCounterpartyList && _selectedCounterparty == null)
          Container(
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: borderColor),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(20),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            constraints: const BoxConstraints(maxHeight: 300),
            child: _buildCounterpartyList(counterpartiesState, l10n),
          ),
      ],
    );
  }

  Widget _buildCounterpartyList(CounterpartyListState state, AppLocalizations l10n) {
    final scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels >= 
          scrollController.position.maxScrollExtent - 50) {
        if (state.hasMore && !state.isLoadingNextPage) {
          ref.read(counterpartiesProvider.notifier).fetchNextPage();
        }
      }
    });

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: borderColor)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.selectCounterparty,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: textDarkColor,
                ),
              ),
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
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  ),
                )
              : state.error != null && state.counterparties.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(l10n.errorLoadingCounterparties),
                      ),
                    )
                  : state.counterparties.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(l10n.noCounterpartiesFound),
                          ),
                        )
                      : Scrollbar(
                          child: ListView.builder(
                            controller: scrollController,
                            shrinkWrap: true,
                            itemCount: state.counterparties.length + (state.hasMore ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == state.counterparties.length) {
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(16),
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                              
                              final counterparty = state.counterparties[index];
                              return Container(
                                decoration: const BoxDecoration(
                                  border: Border(bottom: BorderSide(color: borderColor)),
                                ),
                                child: ListTile(
                                  title: Text(
                                    counterparty.name,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  subtitle: counterparty.phone != null 
                                      ? Text(
                                          counterparty.phone!,
                                          style: const TextStyle(fontSize: 12),
                                        )
                                      : null,
                                  trailing: Icon(
                                    PhosphorIconsRegular.arrowRight,
                                    size: 16,
                                    color: textGreyColor,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _selectedCounterparty = counterparty;
                                      _counterpartySearchController.text = counterparty.name;
                                      _counterpartyError = null;
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

  Widget _buildCommentSection(BuildContext context, AppLocalizations l10n) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.commentLabel,
            style: const TextStyle(
              color: textDarkColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _commentController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: l10n.commentHint,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: borderColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsTable(BuildContext context, TextTheme textTheme, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Row(
              children: [
                const _TableHeaderCell('№', flex: 1),
                _TableHeaderCell(l10n.tableItem, flex: 4),
                _TableHeaderCell(l10n.tableSku, flex: 3),
                _TableHeaderCell(l10n.tableQuantity, flex: 2),
                _TableHeaderCell(l10n.tableUnit, flex: 2),
                _TableHeaderCell(l10n.tablePrice, flex: 2),
                _TableHeaderCell(l10n.tableSum, flex: 2),
                const _TableHeaderCell('', flex: 1),
              ],
            ),
          ),
          const Divider(height: 1, color: borderColor),
          if (_items.isEmpty)
             Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Text(l10n.noItemsAdded,
                  style: const TextStyle(color: textGreyColor)),
            )
          else
            ..._items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return _DocumentItemRow(
                key: ValueKey(item.variantId),
                item: item,
                onChanged: (newItem) => _updateItem(index, newItem),
                onRemove: () => _removeItem(index),
              );
            }),
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
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                icon: Icon(PhosphorIconsRegular.listPlus, size: 20),
                label: Text(l10n.selectItems),
              ),
            ),
          ),
          if (_itemsError != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                _itemsError!,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context, double totalSum, AppLocalizations l10n) {
    final numberFormat = NumberFormat('#,##0.00', 'ru_RU');

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                l10n.totalItems(_items.length),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: textDarkColor,
                ),
              ),
              const SizedBox(width: 24),
              if (_items.isNotEmpty)
                Text(
                  l10n.totalSum(numberFormat.format(totalSum)),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: textDarkColor,
                  ),
                ),
            ],
          ),
          Row(
            children: [
              OutlinedButton(
                onPressed: _isLoading ? null : _saveDocument,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  side: const BorderSide(color: borderColor),
                ),
                child: Text(l10n.save),
              ),
              const SizedBox(width: 12),
              FilledButton(
                onPressed: _isLoading ? null : _postAndClose,
                style: FilledButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: _isLoading 
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : Text(l10n.postAndClose),
              ),
            ],
          ),
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

class DocumentItemRow {
  final int index;
  final int variantId;
  final String productName;
  final String sku;
  final int quantity;
  final double price;
  final String unit;

  DocumentItemRow({
    required this.index,
    required this.variantId,
    this.productName = '',
    this.sku = '',
    this.quantity = 0,
    this.price = 0,
    this.unit = 'pcs',
  });

  double get sum => quantity * price;

  DocumentItemRow copyWith({
    int? index,
    int? variantId,
    String? productName,
    String? sku,
    int? quantity,
    double? price,
    String? unit,
  }) {
    return DocumentItemRow(
      index: index ?? this.index,
      variantId: variantId ?? this.variantId,
      productName: productName ?? this.productName,
      sku: sku ?? this.sku,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      unit: unit ?? this.unit,
    );
  }
}

class _DocumentItemRow extends StatefulWidget {
  final DocumentItemRow item;
  final Function(DocumentItemRow) onChanged;
  final VoidCallback onRemove;

  const _DocumentItemRow({
    super.key,
    required this.item,
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
    _quantityController =
        TextEditingController(text: widget.item.quantity.toString());
    _priceController =
        TextEditingController(text: widget.item.price.toStringAsFixed(2));
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
    widget.onChanged(widget.item.copyWith(
      quantity: quantity,
      price: price,
    ));
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat('#,##0.00', 'ru_RU');

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(widget.item.index.toString(),
                      style: const TextStyle(color: textGreyColor, fontSize: 14)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 4,
                child: Text(
                  widget.item.productName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 3,
                child: Text(
                  widget.item.sku,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: textGreyColor, fontSize: 13),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: TextFormField(
                  controller: _quantityController,
                  onChanged: (_) => _updateFromControllers(),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: _textFieldDecoration(),
                  textAlign: TextAlign.right,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(widget.item.unit,
                      style: const TextStyle(color: textGreyColor, fontSize: 14)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: TextFormField(
                  controller: _priceController,
                  onChanged: (_) => _updateFromControllers(),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: _textFieldDecoration(),
                  textAlign: TextAlign.right,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: Text(
                  numberFormat.format(widget.item.sum),
                  textAlign: TextAlign.right,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 1,
                child: Center(
                  child: IconButton(
                    icon: Icon(PhosphorIconsRegular.trash,
                        color: Colors.red.shade400, size: 20),
                    onPressed: widget.onRemove,
                    splashRadius: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1, color: borderColor),
      ],
    );
  }
}