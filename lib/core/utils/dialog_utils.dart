// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:warehousesys/core/theme/app_theme.dart';

Future<void> showBeautifulDeleteDialog({
  required BuildContext context,
  required String title,
  required String content,
  required String itemName,
  required VoidCallback onDelete,
}) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      icon: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: const Icon(PhosphorIconsFill.warning, color: Colors.red, size: 32),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: textDarkColor)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(content, textAlign: TextAlign.center, style: const TextStyle(color: textGreyColor, fontSize: 14)),
          const SizedBox(height: 8),
          Text(itemName, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600, color: textDarkColor)),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.pop(ctx),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            side: const BorderSide(color: borderColor),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            foregroundColor: textHeaderColor,
          ),
          child: const Text("Отмена"),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: () {
            onDelete();
            Navigator.pop(ctx);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 0,
          ),
          child: const Text("Удалить"),
        ),
      ],
    ),
  );
}

Future<void> showStyledFormDialog({
  required BuildContext context,
  required String title,
  required IconData icon,
  required Widget content,
  required VoidCallback onSave,
  String saveLabel = "Сохранить",
  bool isLoading = false,
}) {
  return showDialog(
    context: context,
    barrierDismissible: !isLoading,
    builder: (ctx) => Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 400,
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Icon(icon, size: 48, color: primaryColor.withOpacity(0.2)),
                  const SizedBox(height: 16),
                  Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textDarkColor), textAlign: TextAlign.center),
                ],
              ),
            ),
            
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: content,
              ),
            ),
            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: backgroundLightColor,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
                border: Border(top: BorderSide(color: borderColor)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: isLoading ? null : () => Navigator.pop(ctx),
                    child: const Text("Отмена", style: TextStyle(color: textGreyColor)),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: isLoading ? null : onSave,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: isLoading 
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : Text(saveLabel),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Future<void> showBeautifulConfirmDialog({
  required BuildContext context,
  required String title,
  required String content,
  required VoidCallback onConfirm,
  String confirmLabel = "Подтвердить",
  bool isPrimary = true,
}) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      icon: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: (isPrimary ? primaryColor : textGreyColor).withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          PhosphorIconsFill.question, 
          color: isPrimary ? primaryColor : textGreyColor, 
          size: 32
        ),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: textDarkColor)),
      content: Text(content, textAlign: TextAlign.center, style: const TextStyle(color: textGreyColor, fontSize: 14)),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.pop(ctx),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            side: const BorderSide(color: borderColor),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            foregroundColor: textHeaderColor,
          ),
          child: const Text("Отмена"),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: () {
            onConfirm();
            Navigator.pop(ctx);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isPrimary ? primaryColor : textHeaderColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 0,
          ),
          child: Text(confirmLabel),
        ),
      ],
    ),
  );
}

Future<void> showSelectionDialog({
  required BuildContext context,
  required String title,
  required List<SelectionOption> options,
}) {
  return showDialog(
    context: context,
    builder: (ctx) => Dialog(
      backgroundColor: backgroundLightColor,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textDarkColor)),
                IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
              ],
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: options.map((option) => _SelectionCard(option: option)).toList(),
            ),
          ],
        ),
      ),
    ),
  );
}

class SelectionOption {
  final String title;
  final String? description;
  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  SelectionOption({
    required this.title,
    this.description,
    required this.icon,
    required this.onTap,
    this.color = primaryColor,
  });
}

class _SelectionCard extends StatefulWidget {
  final SelectionOption option;
  const _SelectionCard({required this.option});

  @override
  State<_SelectionCard> createState() => _SelectionCardState();
}

class _SelectionCardState extends State<_SelectionCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
          widget.option.onTap();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 210,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _isHovered ? widget.option.color.withOpacity(0.5) : borderColor),
            boxShadow: _isHovered
                ? [BoxShadow(color: widget.option.color.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))]
                : [],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: widget.option.color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(widget.option.icon, size: 28, color: widget.option.color),
              ),
              const SizedBox(height: 16),
              Text(widget.option.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textDarkColor), textAlign: TextAlign.center),
              if (widget.option.description != null) ...[
                const SizedBox(height: 8),
                Text(widget.option.description!, style: const TextStyle(fontSize: 12, color: textGreyColor), textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis),
              ]
            ],
          ),
        ),
      ),
    );
  }
}