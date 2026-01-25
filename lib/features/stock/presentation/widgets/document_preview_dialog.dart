import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warehousesys/core/theme/app_theme.dart';
import 'package:warehousesys/features/stock/data/models/document_details.dart';
import 'package:warehousesys/features/stock/presentation/providers/stock_providers.dart';
import 'package:intl/intl.dart';
import 'package:warehousesys/l10n/app_localizations.dart';

class DocumentPreviewDialog extends ConsumerWidget {
  final int documentId;
  final int highlightedVariantId;

  const DocumentPreviewDialog({
    super.key,
    required this.documentId,
    required this.highlightedVariantId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documentAsync = ref.watch(documentDetailsProvider(documentId));
    final l10n = AppLocalizations.of(context)!;
    
    return Dialog(
      backgroundColor: cardBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 672), 
        child: documentAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, s) => Center(child: Text(l10n.documentErrorLoading(e))),
          data: (doc) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Header(doc: doc),
              Flexible(
                child: SingleChildScrollView(
                  child: _Body(doc: doc, highlightedVariantId: highlightedVariantId),
                ),
              ),
              _Actions(documentId: doc.id),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final DocumentDetailsDTO doc;
  const _Header({required this.doc});
  
  String _getDocumentTypeName(String type, AppLocalizations l10n) {
    switch (type) {
      case 'INCOME': return l10n.incomeNote;
      case 'OUTCOME': return l10n.outcomeNote;
      default: return type;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 8, 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: borderColor))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${_getDocumentTypeName(doc.type, l10n)} № ${doc.number}', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
          IconButton(
            icon: const Icon(Icons.close, color: textGreyColor),
            onPressed: () => Navigator.of(context).pop(),
            tooltip: l10n.close,
          ),
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final DocumentDetailsDTO doc;
  final int highlightedVariantId;
  const _Body({required this.doc, required this.highlightedVariantId});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(l10n.basicInformation),
          const SizedBox(height: 16),
          _InfoGrid(doc: doc),
          const SizedBox(height: 24),
          _SectionHeader(l10n.documentContent),
          const SizedBox(height: 12),
          _ItemsTable(items: doc.items, highlightedVariantId: highlightedVariantId),
        ],
      ),
    );
  }
}

class _Actions extends StatelessWidget {
  final int documentId;
  const _Actions({required this.documentId});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: tableHeaderColor,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
        border: Border(top: BorderSide(color: borderColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(onPressed: () => Navigator.of(context).pop(), child: Text(l10n.close)),
          const SizedBox(width: 12),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text(l10n.goToDocument),
          ),
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
    return Text(title, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600, color: textDarkColor));
  }
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String? value;
  final Widget? child;
  final CrossAxisAlignment? alignment;

  const _InfoItem({required this.label, this.value, this.child, this.alignment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment ?? CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: textGreyColor, fontSize: 13)),
        const SizedBox(height: 4),
        child ?? Text(value ?? '', style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
      ],
    );
  }
}

class _InfoGrid extends StatelessWidget {
  final DocumentDetailsDTO doc;
  const _InfoGrid({required this.doc});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   _InfoItem(
                    label: l10n.dateLabel,
                    value: DateFormat('dd.MM.yyyy HH:mm').format(doc.createdAt.toLocal()),
                  ),
                  const SizedBox(height: 12),
                  _InfoItem(label: l10n.statusLabel, child: _StatusChip(status: doc.status)),
                ],
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (doc.warehouseName != null)
                    _InfoItem(label: l10n.warehouseLabelColon, value: doc.warehouseName!, alignment: CrossAxisAlignment.end),
                  const SizedBox(height: 12),
                   if (doc.counterpartyName != null)
                    _InfoItem(label: l10n.counterpartyLabelColon, value: doc.counterpartyName!, alignment: CrossAxisAlignment.end),
                ],
              ),
            ),
          ],
        ),
        if (doc.comment?.isNotEmpty == true) ...[
          const SizedBox(height: 12),
          _InfoItem(
            label: l10n.commentLabelColon,
            value: doc.comment!,
          ),
        ]
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Color color = Colors.grey;
    Color bgColor = Colors.grey.shade100;

    if (status == 'posted') {
      color = statusInStockText;
      bgColor = statusInStockBg;
    } else if (status == 'draft') {
      color = textGreyColor;
      bgColor = Colors.grey.shade200;
    }
    
    String statusText = status;
    if (status == 'posted') statusText = l10n.statusPosted;
    if (status == 'draft') statusText = l10n.statusDraft;

    return Chip(
      label: Text(statusText, style: TextStyle(color: color, fontWeight: FontWeight.w500, fontSize: 12)),
      backgroundColor: bgColor,
      side: BorderSide.none,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      labelPadding: const EdgeInsets.symmetric(horizontal: 4),
    );
  }
}

class _ItemsTable extends StatelessWidget {
  final List<DocumentItemDTO> items;
  final int highlightedVariantId;
  const _ItemsTable({required this.items, required this.highlightedVariantId});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final headerStyle = textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold, color: textHeaderColor, letterSpacing: 0.5);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            color: tableHeaderColor,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(flex: 1, child: Text(l10n.tableNumberShort, style: headerStyle)),
                Expanded(flex: 6, child: Text(l10n.tableItemSku, style: headerStyle)),
                Expanded(flex: 2, child: Text(l10n.tableQtyShort, style: headerStyle, textAlign: TextAlign.right)),
              ],
            ),
          ),
          const Divider(height: 1),
          ...items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isHighlighted = item.variantId == highlightedVariantId;
            final qty = double.tryParse(item.quantity) ?? 0;
            
            final highlightColor = primaryColor.withOpacity(0.1);
            final textStyle = isHighlighted 
                ? const TextStyle(fontWeight: FontWeight.bold, color: primaryColor) 
                : const TextStyle();

            return Container(
              color: isHighlighted ? highlightColor : null,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        Expanded(flex: 1, child: Text((index + 1).toString(), style: textStyle)),
                        Expanded(flex: 6, child: Text('${item.productName} (${item.variantSku})', style: textStyle, overflow: TextOverflow.ellipsis)),
                        Expanded(flex: 2, child: Text(qty.toStringAsFixed(2), style: textStyle, textAlign: TextAlign.right)),
                      ],
                    ),
                  ),
                  if (index < items.length - 1)
                    const Divider(height: 1),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}