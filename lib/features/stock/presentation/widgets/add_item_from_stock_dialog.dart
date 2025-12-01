// lib/features/stock/presentation/widgets/add_item_from_stock_dialog.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:warehousesys/core/theme/app_theme.dart';
import 'package:warehousesys/features/stock/data/models/variant.dart';
import 'package:warehousesys/features/stock/presentation/providers/stock_providers.dart';

final _dialogFilterProvider = StateProvider.autoDispose<VariantFilter>((ref) {
  return const VariantFilter();
});

final _dialogInventoryProvider =
    StateNotifierProvider.autoDispose<InventoryNotifier, InventoryState>((ref) {
      final stockRepository = ref.watch(stockRepositoryProvider);
      final filter = ref.watch(_dialogFilterProvider);
      return InventoryNotifier(stockRepository, filter);
    });

class AddItemFromStockDialog extends ConsumerStatefulWidget {
  const AddItemFromStockDialog({super.key});

  @override
  ConsumerState<AddItemFromStockDialog> createState() =>
      _AddItemFromStockDialogState();
}

class _AddItemFromStockDialogState
    extends ConsumerState<AddItemFromStockDialog> {
  final Set<InventoryItem> _selectedItems = {};
  Timer? _debounce;
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(_dialogInventoryProvider.notifier).fetchNextPage();
    }
  }

  void _toggleSelection(InventoryItem item) {
    setState(() {
      final isSelected = _selectedItems.any((i) => i.id == item.id);
      if (isSelected) {
        _selectedItems.removeWhere((i) => i.id == item.id);
      } else {
        _selectedItems.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final inventoryState = ref.watch(_dialogInventoryProvider);

    return Dialog(
      backgroundColor: cardBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 900,
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: Column(
                children: [
                  Text(
                    'Select Items from Stock',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      _debounce?.cancel();
                      _debounce = Timer(const Duration(milliseconds: 500), () {
                        ref
                            .read(_dialogFilterProvider.notifier)
                            .update(
                              (state) => state.copyWith(name: value, offset: 0),
                            );
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search for items by name or SKU...',
                      prefixIcon: Icon(
                        PhosphorIconsRegular.magnifyingGlass,
                        color: textGreyColor,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const _HeaderRow(),
            const Divider(height: 1, thickness: 1),

            Expanded(
              child: inventoryState.isLoadingFirstPage
                  ? const Center(child: CircularProgressIndicator())
                  : inventoryState.error != null
                  ? Center(child: Text('Error: ${inventoryState.error}'))
                  : inventoryState.items.isEmpty
                  ? const Center(child: Text('No items found.'))
                  : ListView.separated(
                      controller: _scrollController,
                      itemCount:
                          inventoryState.items.length +
                          (inventoryState.hasMore ? 1 : 0),
                      separatorBuilder: (context, index) =>
                          const Divider(height: 1, thickness: 1),
                      itemBuilder: (context, index) {
                        if (index == inventoryState.items.length) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        final item = inventoryState.items[index];
                        final isSelected = _selectedItems.any(
                          (i) => i.id == item.id,
                        );

                        return _StockItemRow(
                          item: item,
                          isSelected: isSelected,
                          onToggle: () => _toggleSelection(item),
                        );
                      },
                    ),
            ),
            _buildActionsBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildActionsBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: tableHeaderColor,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          const SizedBox(width: 16),
          FilledButton.icon(
            icon: Badge(
              isLabelVisible: _selectedItems.isNotEmpty,
              label: Text(_selectedItems.length.toString()),
              child: const Icon(Icons.add),
            ),
            onPressed: _selectedItems.isEmpty
                ? null
                : () => Navigator.of(context).pop(_selectedItems.toList()),
            label: const Text('Add Selected'),
          ),
        ],
      ),
    );
  }
}

class _HeaderRow extends StatelessWidget {
  const _HeaderRow();

  @override
  Widget build(BuildContext context) {
    final headerStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
      fontWeight: FontWeight.bold,
      color: textHeaderColor,
      letterSpacing: 0.5,
    );

    return Container(
      color: tableHeaderColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const SizedBox(width: 40),
          Expanded(flex: 4, child: Text('PRODUCT NAME', style: headerStyle)),
          Expanded(flex: 3, child: Text('SKU', style: headerStyle)),
          Expanded(flex: 2, child: Text('CATEGORY', style: headerStyle)),
          Expanded(flex: 2, child: Text('IN STOCK', style: headerStyle, textAlign: TextAlign.right)),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}

class _StockItemRow extends StatelessWidget {
  final InventoryItem item;
  final bool isSelected;
  final VoidCallback onToggle;

  const _StockItemRow({
    required this.item,
    required this.isSelected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final inStockQty = double.tryParse(item.quantityOnStock) ?? 0;
    final inStockColor = inStockQty > 0 ? textDarkColor : statusOutOfStockText;

    return InkWell(
      onTap: onToggle,
      hoverColor: primaryColor.withOpacity(0.05),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
              value: isSelected,
              onChanged: (_) => onToggle(),
              activeColor: primaryColor,
            ),
            Expanded(
              flex: 4,
              child: Text(
                item.productName,
                style: textTheme.bodyMedium?.copyWith(
                  color: textDarkColor,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 3,
              child: Text(
                item.sku,
                style: textTheme.bodyMedium?.copyWith(color: textGreyColor),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: Text(
                item.categoryName,
                style: textTheme.bodySmall?.copyWith(color: textGreyColor),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: Text(
                '${inStockQty.toStringAsFixed(2)} ${item.unitName}',
                style: textTheme.bodyMedium?.copyWith(
                  color: inStockColor,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}