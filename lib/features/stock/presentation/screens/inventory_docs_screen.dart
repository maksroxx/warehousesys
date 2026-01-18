import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:warehousesys/core/theme/app_theme.dart';
import 'package:warehousesys/features/stock/data/models/document.dart';
import 'package:warehousesys/features/stock/presentation/providers/stock_providers.dart';
import 'package:warehousesys/features/stock/presentation/screens/create_document_screen.dart';
import 'package:warehousesys/features/stock/presentation/screens/document_details_screen.dart';
import 'package:warehousesys/l10n/app_localizations.dart';

class InventoryDocsScreen extends ConsumerStatefulWidget {
  const InventoryDocsScreen({super.key});

  @override
  ConsumerState<InventoryDocsScreen> createState() => _InventoryDocsScreenState();
}

class _InventoryDocsScreenState extends ConsumerState<InventoryDocsScreen> {
  final _scrollController = ScrollController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.refresh(inventoryDocsProvider);
    });
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
      ref.read(inventoryDocsProvider.notifier).fetchNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final documentsState = ref.watch(inventoryDocsProvider);
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, textTheme, l10n),
          const SizedBox(height: 32),
          TextField(
            onChanged: (value) {
              if (_debounce?.isActive ?? false) _debounce!.cancel();
              _debounce = Timer(const Duration(milliseconds: 500), () {
                ref.read(inventoryDocsFilterProvider.notifier).update((state) => state.copyWith(search: value));
              });
            },
            decoration: InputDecoration(
              hintText: l10n.searchInventoryHint,
              prefixIcon: const Icon(PhosphorIconsRegular.magnifyingGlass, color: textGreyColor, size: 20),
              fillColor: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(child: _buildContent(documentsState, l10n)),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, TextTheme textTheme, AppLocalizations l10n) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(l10n.inventoryDocs, style: textTheme.headlineMedium),
        ElevatedButton.icon(
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CreateDocumentScreen(documentType: 'INVENTORY'),
              ),
            );
            ref.refresh(inventoryDocsProvider);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 1,
          ),
          icon: const Icon(PhosphorIconsRegular.plus),
          label: Text(l10n.createInventory),
        ),
      ],
    );
  }

  Widget _buildContent(DocumentListState state, AppLocalizations l10n) {
    if (state.isLoadingFirstPage) return const Center(child: CircularProgressIndicator());
    if (state.error != null && state.documents.isEmpty) return Center(child: Text('${l10n.error}: ${state.error}'));
    if (state.documents.isEmpty) return Center(child: Text(l10n.noInventoryFound));

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
        return _InventoryCard(document: state.documents[index]);
      },
    );
  }
}

class _InventoryCard extends ConsumerWidget {
  final DocumentListItem document;
  const _InventoryCard({required this.document});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final dateFormat = DateFormat('yyyy-MM-dd');
    final l10n = AppLocalizations.of(context)!;

    return InkWell(
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => DocumentDetailsScreen(documentId: document.id)),
        );
        ref.refresh(inventoryDocsProvider);
      },
      borderRadius: BorderRadius.circular(12),
      hoverColor: primaryColor.withOpacity(0.05),
      child: Container(
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
                Text(document.number, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                _StatusChip(status: document.status),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "${l10n.tableWarehouse}: ${document.warehouseName ?? '-'}",
              style: textTheme.bodySmall?.copyWith(color: textGreyColor),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(l10n.cardCreated(dateFormat.format(document.createdAt.toLocal())), style: textTheme.bodySmall?.copyWith(color: textGreyColor)),
                Text(l10n.cardItems(document.totalItems), style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500)),
              ],
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: Text(l10n.viewDetails, style: textTheme.bodyMedium?.copyWith(color: primaryColor)),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Color textColor = textGreyColor;
    Color bgColor = Colors.grey.shade100;
    String text = status;

    if (status == 'posted') {
      textColor = Colors.green.shade800;
      bgColor = Colors.green.shade100;
      text = l10n.statusPosted;
    } else if (status == 'draft') {
      textColor = Colors.orange.shade800;
      bgColor = Colors.orange.shade100;
      text = l10n.statusDraft;
    } else if (status == 'canceled') {
      textColor = Colors.red.shade800;
      bgColor = Colors.red.shade100;
      text = l10n.statusCanceled;
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