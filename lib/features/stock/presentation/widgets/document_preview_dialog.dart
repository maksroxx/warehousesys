import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warehousesys/core/theme/app_theme.dart';
import 'package:warehousesys/features/stock/data/models/document_details.dart';
import 'package:warehousesys/features/stock/presentation/providers/stock_providers.dart';
import 'package:intl/intl.dart';

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
    
    return Dialog(
      backgroundColor: cardBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 672),
        child: documentAsync.when(
          loading: () => const SizedBox(height: 300, child: Center(child: CircularProgressIndicator())),
          error: (e, s) => SizedBox(height: 300, child: Center(child: Text('Ошибка загрузки документа: $e'))),
          data: (doc) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Header(doc: doc),
              Flexible(
                child: SingleChildScrollView(
                  child: _Body(doc: doc, highlightedVariantId: highlightedVariantId),
                ),
              ),
              _Actions(),
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
  
  String _getDocumentTypeName(String type) {
    switch (type) {
      case 'INCOME': return 'Приходная накладная';
      case 'OUTCOME': return 'Расходная накладная';
      default: return type;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 8, 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: borderColor))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${_getDocumentTypeName(doc.type)} № ${doc.number}', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
          IconButton(
            icon: const Icon(Icons.close, color: textGreyColor),
            onPressed: () => Navigator.of(context).pop(),
            tooltip: 'Закрыть',
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
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader('Основная информация'),
          const SizedBox(height: 16),
          _InfoGrid(doc: doc),
          const SizedBox(height: 24),
          _SectionHeader('Содержимое документа'),
          const SizedBox(height: 12),
          _ItemsTable(items: doc.items, highlightedVariantId: highlightedVariantId),
        ],
      ),
    );
  }
}

class _Actions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          OutlinedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Закрыть')),
          const SizedBox(width: 12),
          FilledButton(onPressed: () {}, child: const Text('Перейти к документу')),
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

  const _InfoItem({required this.label, this.value, this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
    final List<Widget> infoItems = [
      _InfoItem(
        label: 'Дата:',
        value: DateFormat('dd.MM.yyyy HH:mm').format(doc.createdAt.toLocal()),
      ),
      if (doc.warehouseName != null)
        _InfoItem(label: 'Склад:', value: doc.warehouseName!),
      if (doc.counterpartyName != null)
        _InfoItem(label: 'Контрагент:', value: doc.counterpartyName!),
      _InfoItem(label: 'Статус:', child: _StatusChip(status: doc.status)),
    ];

    List<Widget> gridRows = [];
    for (var i = 0; i < infoItems.length; i += 2) {
      gridRows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: infoItems[i]),
              const SizedBox(width: 24),
              Expanded(
                child: (i + 1 < infoItems.length) ? infoItems[i + 1] : Container(),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...gridRows,
        if (doc.comment?.isNotEmpty == true)
          _InfoItem(
            label: 'Комментарий:',
            value: doc.comment!,
          ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
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
    if (status == 'posted') statusText = 'Проведен';
    if (status == 'draft') statusText = 'Черновик';

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
    final numberFormat = NumberFormat("#,##0.00", "ru_RU");

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: DataTable(
        headingRowColor: WidgetStateProperty.all(tableHeaderColor),
        headingTextStyle: headerStyle,
        columns: const [
          DataColumn(label: Text('#')),
          DataColumn(label: Text('ТОВАР (SKU)')),
          DataColumn(label: Text('КОЛ-ВО'), numeric: true),
          DataColumn(label: Text('ЦЕНА'), numeric: true),
          DataColumn(label: Text('СУММА'), numeric: true),
        ],
        rows: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isHighlighted = item.variantId == highlightedVariantId;
          final qty = double.tryParse(item.quantity) ?? 0;
          final price = double.tryParse(item.price ?? '0') ?? 0;
          final sum = qty * price;

          final highlightColor = primaryColor.withOpacity(0.1);
          final textStyle = isHighlighted 
              ? const TextStyle(fontWeight: FontWeight.bold, color: primaryColor) 
              : const TextStyle();

          return DataRow(
            color: isHighlighted ? WidgetStateProperty.all(highlightColor) : null,
            cells: [
              DataCell(Text((index + 1).toString(), style: textStyle)),
              DataCell(Text('${item.productName} (${item.variantSku})', style: textStyle, overflow: TextOverflow.ellipsis)),
              DataCell(Text(qty.toStringAsFixed(2), style: textStyle)),
              DataCell(Text(numberFormat.format(price), style: textStyle)),
              DataCell(Text(numberFormat.format(sum), style: textStyle)),
            ],
          );
        }).toList(),
      ),
    );
  }
}