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

Future<String?> showCreateDocumentTypeDialog(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 550), 
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Создать документ',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold, 
                  color: textDarkColor
                ),
              ),
              const SizedBox(height: 6),
              
              const Text(
                'Выберите тип операции',
                style: TextStyle(
                  fontSize: 14, 
                  color: textGreyColor
                ),
              ),
              const SizedBox(height: 24),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: _SelectionCard(
                      label: "Приход",
                      icon: PhosphorIconsRegular.arrowDown,
                      backgroundColor: const Color(0xFFECFDF3),
                      borderColor: const Color(0xFFA6F4C5),
                      textColor: const Color(0xFF027A48),
                      onTap: () => Navigator.pop(context, 'INCOME'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _SelectionCard(
                      label: "Расход",
                      icon: PhosphorIconsRegular.arrowUp,
                      backgroundColor: const Color(0xFFF0F9FF),
                      borderColor: const Color(0xFFB9E6FE),
                      textColor: const Color(0xFF026AA2),
                      onTap: () => Navigator.pop(context, 'OUTCOME'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  foregroundColor: textGreyColor,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                child: const Text("Отмена"),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

class _SelectionCard extends StatefulWidget {
  final String label;
  final IconData icon;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final VoidCallback onTap;

  const _SelectionCard({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    required this.onTap,
  });

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
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          decoration: BoxDecoration(
            color: _isHovered 
                ? Color.alphaBlend(widget.textColor.withOpacity(0.1), widget.backgroundColor) 
                : widget.backgroundColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered ? widget.textColor : widget.borderColor, 
              width: 1.5
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon, 
                size: 28,
                color: widget.textColor
              ),
              const SizedBox(height: 8),
              Text(
                widget.label,
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}