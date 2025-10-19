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
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, textTheme),
          const SizedBox(height: 32),
          _buildFilters(),
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
              child: _buildContent(inventoryState),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(InventoryState state) {
    if (state.isLoadingFirstPage) return const Center(child: CircularProgressIndicator());
    if (state.error != null && state.items.isEmpty) return Center(child: Text('Ошибка загрузки данных:\n${state.error}', textAlign: TextAlign.center));
    if (state.items.isEmpty) return const Center(child: Text('Товары не найдены'));

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(categoriesProvider);
        ref.invalidate(warehousesProvider);
        
        return ref.read(inventoryProvider.notifier).refresh();
      },
      child: Column(children: [
        _InventoryListRow(isHeader: true),
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

  Widget _buildHeader(BuildContext context, TextTheme textTheme) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [ Text('Inventory Management', style: textTheme.headlineMedium), ElevatedButton(onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddItemDialog(),
          );
        }, 
        style: ElevatedButton.styleFrom(backgroundColor: primaryColor, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), elevation: 1), child: Text('Add Item', style: textTheme.bodyMedium?.copyWith(color: Colors.white)))]);
  }

  Widget _buildFilters() {
    return Column(children: [ TextField(onChanged: (value) { if (_debounce?.isActive ?? false) _debounce!.cancel(); _debounce = Timer(const Duration(milliseconds: 500), () { ref.read(inventoryFilterProvider.notifier).update((state) => state.copyWith(name: value)); }); }, decoration: InputDecoration(hintText: 'Search for items', prefixIcon: Icon(PhosphorIconsRegular.magnifyingGlass, color: textGreyColor, size: 20), fillColor: Theme.of(context).scaffoldBackgroundColor)), const SizedBox(height: 16), Row(children: const [ _CategoryFilterMenu(), SizedBox(width: 16), _WarehouseFilterMenu(), SizedBox(width: 16), _StatusFilterMenu()])]);
  }
}

class _CategoryFilterMenu extends ConsumerWidget {
  const _CategoryFilterMenu();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider);
    final currentFilter = ref.watch(inventoryFilterProvider);

    return PopupMenuButton<int>(
      color: cardBackgroundColor, elevation: 2, offset: const Offset(0, 45),
      shape: RoundedRectangleBorder(side: const BorderSide(color: borderColor), borderRadius: BorderRadius.circular(8)),
      constraints: const BoxConstraints(maxHeight: 300),
      onSelected: (categoryId) {
        ref.read(inventoryFilterProvider.notifier).update((state) => state.copyWith(categoryId: categoryId));
      },
      itemBuilder: (context) => categoriesAsync.when(
        loading: () => [const PopupMenuItem(enabled: false, child: Text("Загрузка..."))],
        error: (e, s) => [const PopupMenuItem(enabled: false, child: Text("Ошибка"))],
        data: (categories) => [
          const PopupMenuItem<int>(value: -1, child: Text("Все категории")),
          ...categories.map((cat) => PopupMenuItem<int>(value: cat.id, child: Text(cat.name))),
        ],
      ),
      child: _FilterButton(
        text: categoriesAsync.when(
          loading: () => "Категория",
          error: (e,s) => "Ошибка",
          data: (categories) {
            if (currentFilter.categoryId == -1) return "Все категории";
            return categories.firstWhere((c) => c.id == currentFilter.categoryId, orElse: () => const Category(id: -1, name: "Категория")).name;
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

    return PopupMenuButton<int>(
      color: cardBackgroundColor, elevation: 2, offset: const Offset(0, 45),
      shape: RoundedRectangleBorder(side: const BorderSide(color: borderColor), borderRadius: BorderRadius.circular(8)),
      constraints: const BoxConstraints(maxHeight: 300),
      onSelected: (warehouseId) {
        ref.read(inventoryFilterProvider.notifier).update((state) => state.copyWith(warehouseId: warehouseId));
      },
      itemBuilder: (context) => warehousesAsync.when(
        loading: () => [const PopupMenuItem(enabled: false, child: Text("Загрузка..."))],
        error: (e, s) => [const PopupMenuItem(enabled: false, child: Text("Ошибка"))],
        data: (warehouses) => [
          const PopupMenuItem<int>(value: -1, child: Text("Все локации")),
          ...warehouses.map((w) => PopupMenuItem<int>(value: w.id, child: Text(w.name))),
        ],
      ),
      child: _FilterButton(
        text: warehousesAsync.when(
          loading: () => "Локация",
          error: (e,s) => "Ошибка",
          data: (warehouses) {
            if (currentFilter.warehouseId == -1) return "Все локации";
            return warehouses.firstWhere((w) => w.id == currentFilter.warehouseId, orElse: () => const Warehouse(id: -1, name: "Локация")).name;
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
    return PopupMenuButton<String>(
      color: cardBackgroundColor, elevation: 2, offset: const Offset(0, 45),
      shape: RoundedRectangleBorder(side: const BorderSide(color: borderColor), borderRadius: BorderRadius.circular(8)),
      constraints: const BoxConstraints(maxHeight: 300),
      onSelected: (statusValue) { ref.read(inventoryFilterProvider.notifier).update((state) => state.copyWith(stockStatus: statusValue)); },
      itemBuilder: (context) => StockStatus.values.map((status) => PopupMenuItem<String>(value: status.value, child: Text(status.displayName))).toList(),
      child: _FilterButton(text: StockStatus.values.firstWhere((s) => s.value == currentFilter.stockStatus, orElse: () => StockStatus.all).displayName),
    );
  }
}

class _InventoryListRow extends StatelessWidget {
  const _InventoryListRow({this.item, this.isHeader = false}); final InventoryItem? item; final bool isHeader;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final headerStyle = textTheme.bodySmall?.copyWith(color: textHeaderColor, fontWeight: FontWeight.w600, letterSpacing: 0.5);
    final regularStyle = textTheme.bodyMedium?.copyWith(color: textGreyColor);
    final primaryStyle = textTheme.bodyMedium?.copyWith(color: textDarkColor);

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
              Expanded(flex: 3, child: Text(isHeader ? 'ITEM NAME' : item!.productName, style: isHeader ? headerStyle : primaryStyle, overflow: TextOverflow.ellipsis)),
              Expanded(flex: 2, child: Text(isHeader ? 'CATEGORY' : item!.categoryName, style: isHeader ? headerStyle : regularStyle, overflow: TextOverflow.ellipsis)),
              Expanded(flex: 2, child: Text(isHeader ? 'SKU' : item!.sku, style: isHeader ? headerStyle : regularStyle, overflow: TextOverflow.ellipsis)),
              Expanded(flex: 2, child: Text(isHeader ? 'QUANTITY' : '${item!.quantityOnStock} ${item!.unitName}', style: isHeader ? headerStyle : regularStyle, overflow: TextOverflow.ellipsis)),
              Expanded(flex: 2, child: Align(alignment: Alignment.centerLeft, child: isHeader ? Text('STATUS', style: headerStyle) : _StatusChip(inStock: (double.tryParse(item!.quantityOnStock) ?? 0) > 0))),
              Expanded(flex: 1, child: Align(alignment: Alignment.center, child: isHeader ? Text('ACTIONS', style: headerStyle) : TextButton(onPressed: () {if (item != null) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ItemDetailsScreen(item: item!),
                                ),
                              );
                            }
    }, child: Text('View', style: textTheme.bodyMedium?.copyWith(color: primaryColor)))))
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
    return Chip(label: Text(inStock ? 'In Stock' : 'Out of Stock'), labelStyle: TextStyle(color: inStock ? statusInStockText : statusOutOfStockText, fontWeight: FontWeight.w500, fontSize: 12), backgroundColor: inStock ? statusInStockBg : statusOutOfStockBg, side: BorderSide.none, padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2));
  }
}