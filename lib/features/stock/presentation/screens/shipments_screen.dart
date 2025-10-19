import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:warehousesys/core/theme/app_theme.dart';
import 'package:warehousesys/features/stock/data/models/document.dart';
import 'package:warehousesys/features/stock/presentation/providers/stock_providers.dart';
import 'package:intl/intl.dart';

class ShipmentsScreen extends ConsumerStatefulWidget {
  const ShipmentsScreen({super.key});
  @override
  ConsumerState<ShipmentsScreen> createState() => _ShipmentsScreenState();
}

class _ShipmentsScreenState extends ConsumerState<ShipmentsScreen> {
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
      ref.read(documentsProvider.notifier).fetchNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final documentsState = ref.watch(documentsProvider);
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
              if (_debounce?.isActive ?? false) _debounce!.cancel();
              _debounce = Timer(const Duration(milliseconds: 500), () {
                ref.read(documentFilterProvider.notifier).update((state) => state.copyWith(search: value));
              });
            },
            decoration: InputDecoration(
              hintText: 'Search shipments...',
              prefixIcon: Icon(PhosphorIconsRegular.magnifyingGlass, color: textGreyColor, size: 20),
              fillColor: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: _buildContent(documentsState),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, TextTheme textTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Shipments', style: textTheme.headlineMedium),
        ElevatedButton(
          onPressed: () {
            // TODO
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 1,
          ),
          child: Text(
            'Create Shipment',
            style: textTheme.bodyMedium?.copyWith(color: Colors.white),
          ),
        )
      ],
    );
  }
  
  Widget _buildContent(DocumentListState state) {
    if (state.isLoadingFirstPage) return const Center(child: CircularProgressIndicator());
    if (state.error != null && state.documents.isEmpty) return Center(child: Text('Error: ${state.error}'));
    if (state.documents.isEmpty) return const Center(child: Text('No shipments found.'));

    return GridView.builder(
      controller: _scrollController,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 400,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.8,
      ),
      itemCount: state.documents.length + (state.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == state.documents.length) {
          return const Center(child: Padding(padding: EdgeInsets.all(16.0), child: CircularProgressIndicator()));
        }
        return ShipmentCard(shipment: state.documents[index]);
      },
    );
  }
}

class ShipmentCard extends StatelessWidget {
  final DocumentListItem shipment;
  const ShipmentCard({super.key, required this.shipment});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final dateFormat = DateFormat('yyyy-MM-dd');

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(shipment.number, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
              _StatusChip(status: shipment.status),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Контрагент: ${shipment.counterpartyName ?? 'N/A'}', 
            style: textTheme.bodySmall?.copyWith(color: textGreyColor),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Отгрузка: ${dateFormat.format(shipment.createdAt.toLocal())}', 
                style: textTheme.bodySmall?.copyWith(color: textGreyColor)
              ),
              Text(
                'Позиций: ${shipment.totalItems}', 
                style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500)
              ),
            ],
          ),
          const Spacer(),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: const Text('View Details'),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    Color textColor = textGreyColor;
    Color bgColor = Colors.grey.shade100;
    String text = status;

    if (status == 'posted') {
      textColor = Colors.green.shade800;
      bgColor = Colors.green.shade100;
      text = 'Posted';
    } else if (status == 'draft') {
      textColor = Colors.orange.shade800;
      bgColor = Colors.orange.shade100;
      text = 'Draft';
    }

    return Chip(
      label: Text(text, style: TextStyle(color: textColor, fontWeight: FontWeight.w500, fontSize: 12)),
      backgroundColor: bgColor,
      side: BorderSide.none,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}