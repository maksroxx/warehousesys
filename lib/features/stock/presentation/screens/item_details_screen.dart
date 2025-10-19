import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:warehousesys/core/theme/app_theme.dart';
import 'package:warehousesys/features/stock/data/models/item_details.dart';
import 'package:warehousesys/features/stock/data/models/variant.dart';
import 'package:warehousesys/features/stock/presentation/providers/stock_providers.dart';
import 'package:warehousesys/features/stock/presentation/widgets/add_item_dialog.dart';
import 'package:warehousesys/features/stock/presentation/widgets/document_preview_dialog.dart';
import 'package:intl/intl.dart';

class ItemDetailsScreen extends ConsumerWidget {
  final InventoryItem item;
  const ItemDetailsScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. "Слушаем" состояние главного списка инвентаря
    final inventoryState = ref.watch(inventoryProvider);

    // 2. Находим самую свежую версию нашего элемента в обновленном списке.
    //    Используем исходный 'item' как запасной вариант, если элемент еще не загрузился.
    final updatedItem = inventoryState.items.firstWhere(
      (i) => i.id == item.id,
      orElse: () => item,
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool useSingleColumn = constraints.maxWidth < 900;
            return Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Header(item: updatedItem),
                  const SizedBox(height: 32),
                  if (useSingleColumn)
                    Column(
                      children: [
                        _LeftColumn(item: updatedItem),
                        const SizedBox(height: 32),
                        _RightColumn(item: updatedItem),
                      ],
                    )
                  else
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 2, child: _LeftColumn(item: updatedItem)),
                        const SizedBox(width: 32),
                        Expanded(flex: 3, child: _RightColumn(item: updatedItem)),
                      ],
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Header extends ConsumerWidget {
  final InventoryItem item;
  const _Header({required this.item});
  Future<void> _showDeleteConfirmationDialog(BuildContext context, WidgetRef ref) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Подтвердите удаление'),
        content: Text('Вы уверены, что хотите удалить вариант "${item.productName}" (SKU: ${item.sku})? Это действие нельзя будет отменить.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Отмена')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await ref.read(stockRepositoryProvider).deleteVariant(item.id);
        if (!context.mounted) return; 
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Товар успешно удален'), backgroundColor: Colors.green));
        ref.invalidate(inventoryProvider);
        Navigator.of(context).pop();
      } catch (e) {
        if (!context.mounted) return; 
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ошибка удаления: $e'), backgroundColor: Colors.red));
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(icon: Icon(PhosphorIconsRegular.arrowLeft), onPressed: () => Navigator.of(context).pop(), tooltip: 'Back to Inventory'),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.productName, style: textTheme.headlineMedium),
              const SizedBox(height: 4),
              Text('SKU: ${item.sku}', style: textTheme.bodyMedium?.copyWith(color: textGreyColor)),
            ],
          ),
        ),
        IconButton(
          icon: Icon(PhosphorIconsRegular.pencilSimple, color: textGreyColor), 
          onPressed: () {
            showDialog(context: context, builder: (context) => AddItemDialog(itemToEdit: item));
          }, 
          tooltip: 'Edit Item'
        ),
        IconButton(
          icon: Icon(PhosphorIconsRegular.trash, color: Colors.red.shade600), 
          onPressed: () => _showDeleteConfirmationDialog(context, ref),
          tooltip: 'Delete Item'
        ),
      ],
    );
  }
}

class _LeftColumn extends ConsumerWidget {
  final InventoryItem item;
  const _LeftColumn({required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productDetailsAsync = ref.watch(detailedProductProvider(item.productId));
    return _InfoCard(
      title: 'Detailed Information',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          productDetailsAsync.when(
            loading: () => const Center(child: Padding(padding: EdgeInsets.all(16.0), child: CircularProgressIndicator())),
            error: (e, s) => Center(child: Text('Ошибка загрузки описания: $e')),
            data: (product) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (product.description?.isNotEmpty == true) ...[
                    _SectionHeader('Description'),
                    Text(product.description!, style: const TextStyle(color: textGreyColor, height: 1.5)),
                    const SizedBox(height: 24),
                  ],
                  _SectionHeader('Attributes'),
                  _AttributeTableRow('Category', item.categoryName),
                  const Divider(height: 24),
                  _AttributeTableRow('Unit', item.unitName),
                ],
              );
            },
          ),
          if (item.characteristics != null && item.characteristics!.isNotEmpty) ...[
            const SizedBox(height: 24),
            _SectionHeader('Characteristics'),
            ...item.characteristics!.entries.map((entry) {
              final isLast = entry.key == item.characteristics!.entries.last.key;
              return Column(
                children: [
                  _AttributeTableRow(entry.key, entry.value),
                  if (!isLast) const Divider(height: 24),
                ],
              );
            }),
          ]
        ],
      ),
    );
  }
}

class _RightColumn extends StatelessWidget {
  final InventoryItem item;
  const _RightColumn({required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _InfoCard(
          title: 'Real-time Data',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionHeader('Stock Levels'),
              Consumer(
                builder: (context, ref, child) {
                  final stockAsync = ref.watch(variantStockProvider(item.id));
                  return stockAsync.when(
                    loading: () => const Center(child: Padding(padding: EdgeInsets.all(16.0), child: CircularProgressIndicator())),
                    error: (e, s) => Center(child: Text('Error: $e')),
                    data: (stocks) => _StockLevelsTable(stocks: stocks),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _InfoCard(
          title: 'Movement History (Last 10)',
          isPadded: false,
          child: Consumer(
            builder: (context, ref, child) {
              final movementsAsync = ref.watch(variantMovementsProvider(item.id));
              return movementsAsync.when(
                loading: () => const Center(child: Padding(padding: EdgeInsets.all(16.0), child: CircularProgressIndicator())),
                error: (e, s) => Center(child: Text('Error: $e')),
                data: (movements) {
                  if (movements.isEmpty) { return const Center(child: Padding(padding: EdgeInsets.all(24.0), child: Text('No movements found.', style: TextStyle(color: textGreyColor)))); }
                  // ✅ ИЗМЕНЕНИЕ: Передаем ID текущего товара в таблицу
                  return _MovementHistoryTable(movements: movements, currentVariantId: item.id);
                }
              );
            },
          ),
        ),
      ],
    );
  }
}


class _InfoCard extends StatelessWidget {
  final String title; final Widget child; final bool isPadded;
  const _InfoCard({required this.title, required this.child, this.isPadded = true});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: Colors.black.withAlpha(12), blurRadius: 4, offset: const Offset(0, 2))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: const EdgeInsets.fromLTRB(24, 24, 24, 16), child: Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold))),
          if (isPadded) Padding(padding: const EdgeInsets.fromLTRB(24, 0, 24, 24), child: child) else child,
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(title, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: textHeaderColor)),
    );
  }
}

class _AttributeTableRow extends StatelessWidget {
  final String label; final String value;
  const _AttributeTableRow(this.label, this.value);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(label, style: const TextStyle(color: textGreyColor, fontWeight: FontWeight.w500))),
          Expanded(flex: 3, child: Text(value, style: const TextStyle(fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}

class _StockLevelsTable extends StatelessWidget {
  final List<VariantStock> stocks;
  const _StockLevelsTable({required this.stocks});
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final headerStyle = textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold, color: textHeaderColor);
    final totalStyle = textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold);
    double totalOnHand = 0, totalReserved = 0, totalAvailable = 0;
    for (var stock in stocks) {
      totalOnHand += double.tryParse(stock.onHand) ?? 0;
      totalReserved += double.tryParse(stock.reserved) ?? 0;
      totalAvailable += double.tryParse(stock.available) ?? 0;
    }
    return DataTable(
      headingRowHeight: 40,
      columns: [
        DataColumn(label: Text('WAREHOUSE', style: headerStyle)),
        DataColumn(label: Text('ON HAND', style: headerStyle), numeric: true),
        DataColumn(label: Text('RESERVED', style: headerStyle), numeric: true),
        DataColumn(label: Text('AVAILABLE', style: headerStyle), numeric: true),
      ],
      rows: [
        ...stocks.map((stock) => DataRow(
          cells: [
            DataCell(Text(stock.warehouseName)),
            DataCell(Text((double.tryParse(stock.onHand) ?? 0).toStringAsFixed(2))),
            DataCell(Text((double.tryParse(stock.reserved) ?? 0).toStringAsFixed(2))),
            DataCell(Text((double.tryParse(stock.available) ?? 0).toStringAsFixed(2))),
          ],
        )),
        DataRow(
          cells: [
            DataCell(Text('Total', style: totalStyle)),
            DataCell(Text(totalOnHand.toStringAsFixed(2), style: totalStyle)),
            DataCell(Text(totalReserved.toStringAsFixed(2), style: totalStyle)),
            DataCell(Text(totalAvailable.toStringAsFixed(2), style: totalStyle)),
          ],
        ),
      ],
    );
  }
}

class _MovementHistoryTable extends StatelessWidget {
  final List<StockMovement> movements;
  final int currentVariantId;
  const _MovementHistoryTable({required this.movements, required this.currentVariantId});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final headerStyle = textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold, color: textHeaderColor);
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');

    return DataTable(
      headingRowHeight: 40,
      columns: [
        DataColumn(label: Text('DATE', style: headerStyle)),
        DataColumn(label: Text('TYPE', style: headerStyle)),
        DataColumn(label: Text('DOCUMENT', style: headerStyle)),
        DataColumn(label: Text('WAREHOUSE', style: headerStyle)),
        DataColumn(label: Text('QUANTITY', style: headerStyle), numeric: true),
      ],
      rows: movements.map((m) {
        final isIncome = m.type == 'INCOME';
        final qty = double.tryParse(m.quantity) ?? 0;
        final qtyText = '${isIncome ? '+' : ''}${qty.toStringAsFixed(2)}';
        
        return DataRow(
          cells: [
            DataCell(Text(dateFormat.format(m.createdAt.toLocal()))),
            DataCell(Text(m.type, style: TextStyle(color: isIncome ? statusInStockText : statusOutOfStockText, fontWeight: FontWeight.bold))),
            DataCell(
              TextButton(
                onPressed: m.documentId != null
                    ? () {
                        showDialog(
                          context: context,
                          builder: (context) => DocumentPreviewDialog(
                            documentId: m.documentId!,
                            highlightedVariantId: currentVariantId,
                          ),
                        );
                      }
                    : null,
                child: Text(m.documentNumber ?? 'N/A'),
              ),
            ),
            DataCell(Text(m.warehouseName)),
            DataCell(Text(qtyText)),
          ]
        );
      }).toList(),
    );
  }
}