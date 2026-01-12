import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:warehousesys/core/theme/app_theme.dart';
import 'package:warehousesys/features/stock/presentation/screens/item_details_screen.dart';
import 'package:warehousesys/features/stock/presentation/widgets/add_item_dialog.dart';
import 'package:warehousesys/features/stock/data/models/filters.dart';
import 'package:warehousesys/features/stock/data/models/variant.dart';
import 'package:warehousesys/features/stock/presentation/providers/stock_providers.dart';
import 'package:warehousesys/l10n/app_localizations.dart';

class InventoryScreen extends ConsumerStatefulWidget {
  const InventoryScreen({super.key});
  @override
  ConsumerState<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends ConsumerState<InventoryScreen> {
  Timer? _debounce;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(inventoryProvider);
      ref.invalidate(categoriesProvider);
      ref.invalidate(warehousesProvider);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      ref.read(inventoryProvider.notifier).fetchNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final inventoryState = ref.watch(inventoryProvider);
    final l10n = AppLocalizations.of(context)!;
    
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, l10n),
          const SizedBox(height: 32),
          _buildFilters(l10n),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: cardBackgroundColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: borderColor),
                boxShadow: [BoxShadow(color: Colors.black.withAlpha((255 * 0.05).round()), blurRadius: 2, offset: const Offset(0, 1))]
              ),
              clipBehavior: Clip.antiAlias,
              child: _buildContent(inventoryState, l10n),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(InventoryState state, AppLocalizations l10n) {
    if (state.isLoadingFirstPage) return const Center(child: CircularProgressIndicator());
    if (state.error != null && state.items.isEmpty) return Center(child: Text(l10n.errorLoadingData(state.error!), textAlign: TextAlign.center));
    if (state.items.isEmpty) return Center(child: Text(l10n.noItemsFound));

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(categoriesProvider);
        ref.invalidate(warehousesProvider);
        
        return ref.read(inventoryProvider.notifier).refresh();
      },
      child: Column(children: [
        const _InventoryListRow(isHeader: true),
        const Divider(height: 1, thickness: 1),
        Expanded(
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            itemCount: state.items.length + (state.hasMore ? 1 : 0),
            separatorBuilder: (context, index) => const Divider(height: 1, thickness: 1),
            itemBuilder: (context, index) {
              if (index == state.items.length) {
                return const Padding(padding: EdgeInsets.symmetric(vertical: 24), child: Center(child: CircularProgressIndicator()));
              }
              return _InventoryListRow(item: state.items[index]);
            },
          ),
        ),
      ]),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations l10n) {
    final textTheme = Theme.of(context).textTheme;
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [ 
      Text(l10n.inventoryManagement, style: textTheme.headlineMedium), 
      // ElevatedButton(
      //   onPressed: () {
      //     showDialog(
      //       context: context,
      //       builder: (context) => const AddItemDialog(),
      //     );
      //   }, 
      //   style: ElevatedButton.styleFrom(backgroundColor: primaryColor, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), elevation: 1), 
      //   child: Text(l10n.addItem, style: textTheme.bodyMedium?.copyWith(color: Colors.white)))
        ]);
  }

  Widget _buildFilters(AppLocalizations l10n) {
    return Column(children: [ 
      TextField(
        onChanged: (value) { 
          if (_debounce?.isActive ?? false) _debounce!.cancel(); 
          _debounce = Timer(const Duration(milliseconds: 500), () { 
            ref.read(inventoryFilterProvider.notifier).update((state) => state.copyWith(name: value)); 
          }); 
        }, 
        decoration: InputDecoration(
          hintText: l10n.searchItemsHint, 
          prefixIcon: Icon(PhosphorIconsRegular.magnifyingGlass, color: textGreyColor, size: 20), 
          fillColor: Theme.of(context).scaffoldBackgroundColor
        )
      ), 
      const SizedBox(height: 16), 
      const Row(children: [ 
        _CategoryFilterMenu(), 
        SizedBox(width: 16), 
        _WarehouseFilterMenu(), 
        SizedBox(width: 16), 
        _StatusFilterMenu()
      ])
    ]);
  }
}

class _CategoryFilterMenu extends ConsumerWidget {
  const _CategoryFilterMenu();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider);
    final currentFilter = ref.watch(inventoryFilterProvider);
    final l10n = AppLocalizations.of(context)!;

    return PopupMenuButton<int>(
      color: cardBackgroundColor, elevation: 2, offset: const Offset(0, 45),
      shape: RoundedRectangleBorder(side: const BorderSide(color: borderColor), borderRadius: BorderRadius.circular(8)),
      constraints: const BoxConstraints(maxHeight: 300),
      onSelected: (categoryId) {
        ref.read(inventoryFilterProvider.notifier).update((state) => state.copyWith(categoryId: categoryId));
      },
      itemBuilder: (context) => categoriesAsync.when(
        loading: () => [PopupMenuItem(enabled: false, child: Text(l10n.loading))],
        error: (e, s) => [PopupMenuItem(enabled: false, child: Text(l10n.error))],
        data: (categories) => [
          PopupMenuItem<int>(value: -1, child: Text(l10n.allCategories)),
          ...categories.map((cat) => PopupMenuItem<int>(value: cat.id, child: Text(cat.name))),
        ],
      ),
      child: _FilterButton(
        text: categoriesAsync.when(
          loading: () => l10n.categoryLabel,
          error: (e,s) => l10n.error,
          data: (categories) {
            if (currentFilter.categoryId == -1) return l10n.allCategories;
            return categories.firstWhere((c) => c.id == currentFilter.categoryId, orElse: () => Category(id: -1, name: l10n.categoryLabel)).name;
          }
        ),
      ),
    );
  }
}

class _WarehouseFilterMenu extends ConsumerWidget {
  const _WarehouseFilterMenu();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final warehousesAsync = ref.watch(warehousesProvider);
    final currentFilter = ref.watch(inventoryFilterProvider);
    final l10n = AppLocalizations.of(context)!;

    return PopupMenuButton<int>(
      color: cardBackgroundColor, elevation: 2, offset: const Offset(0, 45),
      shape: RoundedRectangleBorder(side: const BorderSide(color: borderColor), borderRadius: BorderRadius.circular(8)),
      constraints: const BoxConstraints(maxHeight: 300),
      onSelected: (warehouseId) {
        ref.read(inventoryFilterProvider.notifier).update((state) => state.copyWith(warehouseId: warehouseId));
      },
      itemBuilder: (context) => warehousesAsync.when(
        loading: () => [PopupMenuItem(enabled: false, child: Text(l10n.loading))],
        error: (e, s) => [PopupMenuItem(enabled: false, child: Text(l10n.error))],
        data: (warehouses) => [
          PopupMenuItem<int>(value: -1, child: Text(l10n.allLocations)),
          ...warehouses.map((w) => PopupMenuItem<int>(value: w.id, child: Text(w.name))),
        ],
      ),
      child: _FilterButton(
        text: warehousesAsync.when(
          loading: () => l10n.locationLabel,
          error: (e,s) => l10n.error,
          data: (warehouses) {
            if (currentFilter.warehouseId == -1) return l10n.allLocations;
            return warehouses.firstWhere((w) => w.id == currentFilter.warehouseId, orElse: () => Warehouse(id: -1, name: l10n.locationLabel)).name;
          }
        ),
      ),
    );
  }
}

class _StatusFilterMenu extends ConsumerWidget {
  const _StatusFilterMenu();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentFilter = ref.watch(inventoryFilterProvider);
    final l10n = AppLocalizations.of(context)!;
    
    // Вспомогательная функция для получения локализованного имени статуса
    String getLocalizedStatusName(StockStatus status) {
      if (status == StockStatus.all) return l10n.allStatuses;
      if (status == StockStatus.inStock) return l10n.inStock;
      if (status == StockStatus.outOfStock) return l10n.outOfStock;
      return status.displayName; // Fallback
    }

    return PopupMenuButton<String>(
      color: cardBackgroundColor, elevation: 2, offset: const Offset(0, 45),
      shape: RoundedRectangleBorder(side: const BorderSide(color: borderColor), borderRadius: BorderRadius.circular(8)),
      constraints: const BoxConstraints(maxHeight: 300),
      onSelected: (statusValue) { ref.read(inventoryFilterProvider.notifier).update((state) => state.copyWith(stockStatus: statusValue)); },
      itemBuilder: (context) => StockStatus.values.map((status) => PopupMenuItem<String>(value: status.value, child: Text(getLocalizedStatusName(status)))).toList(),
      child: _FilterButton(
        text: getLocalizedStatusName(StockStatus.values.firstWhere((s) => s.value == currentFilter.stockStatus, orElse: () => StockStatus.all))
      ),
    );
  }
}

class _InventoryListRow extends StatelessWidget {
  const _InventoryListRow({super.key, this.item, this.isHeader = false}); 
  final InventoryItem? item; 
  final bool isHeader;
  
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final headerStyle = textTheme.bodySmall?.copyWith(color: textHeaderColor, fontWeight: FontWeight.w600, letterSpacing: 0.5);
    final regularStyle = textTheme.bodyMedium?.copyWith(color: textGreyColor);
    final primaryStyle = textTheme.bodyMedium?.copyWith(color: textDarkColor);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      color: isHeader ? tableHeaderColor : null,
      child: InkWell(
        onTap: isHeader ? null : () {},
        hoverColor: isHeader ? null : hoverColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 3, child: Text(isHeader ? l10n.tableItemName.toUpperCase() : item!.productName, style: isHeader ? headerStyle : primaryStyle, overflow: TextOverflow.ellipsis)),
              Expanded(flex: 2, child: Text(isHeader ? l10n.tableCategory.toUpperCase() : item!.categoryName, style: isHeader ? headerStyle : regularStyle, overflow: TextOverflow.ellipsis)),
              Expanded(flex: 2, child: Text(isHeader ? l10n.tableSku.toUpperCase() : item!.sku, style: isHeader ? headerStyle : regularStyle, overflow: TextOverflow.ellipsis)),
              Expanded(flex: 2, child: Text(isHeader ? l10n.tableQuantity.toUpperCase() : '${item!.quantityOnStock} ${item!.unitName}', style: isHeader ? headerStyle : regularStyle, overflow: TextOverflow.ellipsis)),
              Expanded(flex: 2, child: Align(alignment: Alignment.centerLeft, child: isHeader ? Text(l10n.tableStatus.toUpperCase(), style: headerStyle) : _StatusChip(inStock: (double.tryParse(item!.quantityOnStock) ?? 0) > 0))),
              Expanded(flex: 1, child: Align(alignment: Alignment.center, child: isHeader ? Text(l10n.tableActions.toUpperCase(), style: headerStyle) : TextButton(onPressed: () {if (item != null) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ItemDetailsScreen(item: item!),
                                ),
                              );
                            }
    }, child: Text(l10n.view, style: textTheme.bodyMedium?.copyWith(color: primaryColor)))))
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  final String text; const _FilterButton({required this.text});
  @override
  Widget build(BuildContext context) {
    return Material(color: cardBackgroundColor, shape: RoundedRectangleBorder(side: const BorderSide(color: borderColor), borderRadius: BorderRadius.circular(8)), child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), child: Row(children: [Text(text, style: Theme.of(context).textTheme.bodyMedium), const SizedBox(width: 8), Icon(PhosphorIconsRegular.caretDown, color: textGreyColor, size: 16)])));
  }
}

class _StatusChip extends StatelessWidget {
  final bool inStock; const _StatusChip({required this.inStock});
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Chip(
      label: Text(inStock ? l10n.inStock : l10n.outOfStock), 
      labelStyle: TextStyle(color: inStock ? statusInStockText : statusOutOfStockText, fontWeight: FontWeight.w500, fontSize: 12), 
      backgroundColor: inStock ? statusInStockBg : statusOutOfStockBg, 
      side: BorderSide.none, 
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2)
    );
  }
}