import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:warehousesys/core/theme/app_theme.dart';
import 'package:warehousesys/features/stock/data/models/counterparty.dart';
import 'package:warehousesys/features/stock/presentation/providers/stock_providers.dart';
import 'package:warehousesys/features/stock/presentation/widgets/add_or_edit_counterparty_dialog.dart';

class CounterpartiesScreen extends ConsumerStatefulWidget {
  const CounterpartiesScreen({super.key});
  @override
  ConsumerState<CounterpartiesScreen> createState() => _CounterpartiesScreenState();
}

class _CounterpartiesScreenState extends ConsumerState<CounterpartiesScreen> {
  final _scrollController = ScrollController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      ref.read(counterpartiesProvider.notifier).fetchNextPage();
    }
  }

  Future<void> _showDeleteConfirmationDialog(Counterparty counterparty) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Подтвердите удаление'),
        content: Text('Вы уверены, что хотите удалить контрагента "${counterparty.name}"? Это действие нельзя будет отменить.'),
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
        await ref.read(stockRepositoryProvider).deleteCounterparty(counterparty.id);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Контрагент успешно удален'), backgroundColor: Colors.green),
        );
        ref.invalidate(counterpartiesProvider);
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка удаления: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final counterpartiesState = ref.watch(counterpartiesProvider);
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, textTheme),
          const SizedBox(height: 32),
          TextField(
            onChanged: (value) {
              _debounce?.cancel();
              _debounce = Timer(const Duration(milliseconds: 500), () {
                ref.read(counterpartyFilterProvider.notifier).update((state) => state.copyWith(search: value));
              });
            },
            decoration: InputDecoration(
              hintText: 'Search counterparties...',
              prefixIcon: Icon(PhosphorIconsRegular.magnifyingGlass, color: textGreyColor, size: 20),
              fillColor: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: _buildContent(counterpartiesState),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, TextTheme textTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Customers', style: textTheme.headlineMedium),
        ElevatedButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const AddOrEditCounterpartyDialog(),
            );
          },
          icon: Icon(PhosphorIconsRegular.plus, color: Colors.white),
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 1,
          ),
          label: const Text('Add Counterparty'),
        ),
      ],
    );
  }

  Widget _buildContent(CounterpartyListState state) {
    if (state.isLoadingFirstPage) return const Center(child: CircularProgressIndicator());
    if (state.error != null && state.counterparties.isEmpty) return Center(child: Text('Error: ${state.error}'));
    if (state.counterparties.isEmpty) return const Center(child: Text('No counterparties found.'));

    return Container(
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          _buildTableHeader(),
          const Divider(height: 1, thickness: 1),
          Expanded(
            child: ListView.separated(
              controller: _scrollController,
              itemCount: state.counterparties.length + (state.hasMore ? 1 : 0),
              separatorBuilder: (context, index) => const Divider(height: 1, thickness: 1),
              itemBuilder: (context, index) {
                if (index == state.counterparties.length) {
                  return const Center(child: Padding(padding: EdgeInsets.all(16.0), child: CircularProgressIndicator()));
                }
                return _buildTableRow(state.counterparties[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      color: tableHeaderColor,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        children: [
          _HeaderCell('Name', flex: 2),
          _HeaderCell('Phone', flex: 2),
          _HeaderCell('Email', flex: 2),
          _HeaderCell('Telegramm', flex: 2),
          _HeaderCell('Address', flex: 3),
          _HeaderCell('', flex: 1, alignment: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildTableRow(Counterparty item) {
    return InkWell(
      onTap: () {},
      hoverColor: hoverColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _DataCell((item.name.isNotEmpty) ? item.name : '-', flex: 2, isPrimary: true),
            _DataCell((item.phone != null && item.phone!.isNotEmpty) ? item.phone! : '-', flex: 2),
            _DataCell((item.email != null && item.email!.isNotEmpty) ? item.email! : '-', flex: 2),
            _DataCell((item.telegram != null && item.telegram!.isNotEmpty) ? item.telegram! : '-', flex: 2),
            _DataCell((item.address != null && item.address!.isNotEmpty) ? item.address! : '-', flex: 3),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(PhosphorIconsRegular.pencilSimple, color: textGreyColor, size: 20),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AddOrEditCounterpartyDialog(counterpartyToEdit: item),
                      );
                    },
                    tooltip: 'Edit Counterparty',
                  ),
                  IconButton(
                    icon: Icon(PhosphorIconsRegular.trash, color: Colors.red.shade600, size: 20),
                    onPressed: () => _showDeleteConfirmationDialog(item),
                    tooltip: 'Delete Counterparty',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Вспомогательные виджеты ---
class _HeaderCell extends StatelessWidget {
  final String text;
  final int flex;
  final TextAlign alignment;
  const _HeaderCell(this.text, {required this.flex, this.alignment = TextAlign.left});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text.toUpperCase(),
        textAlign: alignment,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold, color: textHeaderColor, letterSpacing: 0.5),
      ),
    );
  }
}

class _DataCell extends StatelessWidget {
  final String text; final int flex; final bool isPrimary;
  const _DataCell(this.text, {required this.flex, this.isPrimary = false});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: isPrimary ? textDarkColor : textGreyColor,
          fontWeight: isPrimary ? FontWeight.w600 : FontWeight.normal,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}