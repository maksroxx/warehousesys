import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:warehousesys/core/theme/app_theme.dart';

class StyledHoverCard extends StatefulWidget {
  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool showActions;

  const StyledHoverCard({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onEdit,
    this.onDelete,
    this.showActions = true,
  });

  @override
  State<StyledHoverCard> createState() => _StyledHoverCardState();
}

class _StyledHoverCardState extends State<StyledHoverCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _isHovered ? primaryColor.withOpacity(0.3) : borderColor),
          boxShadow: _isHovered
              ? [BoxShadow(color: primaryColor.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 4))]
              : [const BoxShadow(color: Colors.transparent)],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          leading: widget.leading,
          title: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.w600, color: textDarkColor)),
          subtitle: widget.subtitle != null ? Text(widget.subtitle!, style: const TextStyle(color: textGreyColor, fontSize: 13)) : null,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.trailing != null) widget.trailing!,
              
              if (widget.showActions) ...[
                const SizedBox(width: 16),
                if (widget.onEdit != null)
                  IconButton(
                    icon: Icon(PhosphorIconsRegular.pencilSimple, color: _isHovered ? primaryColor : textGreyColor, size: 20),
                    tooltip: "Редактировать",
                    onPressed: widget.onEdit,
                  ),
                if (widget.onDelete != null)
                  IconButton(
                    icon: Icon(PhosphorIconsRegular.trash, color: _isHovered ? Colors.red : textGreyColor, size: 20),
                    tooltip: "Удалить",
                    onPressed: widget.onDelete,
                  ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}