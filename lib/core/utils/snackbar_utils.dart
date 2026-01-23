// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AppSnackbars {
  static void showSuccess(BuildContext context, String message) {
    _show(
      context,
      message,
      icon: PhosphorIconsFill.checkCircle,
      backgroundColor: const Color.fromARGB(255, 0, 180, 0),
      textColor: Colors.white,
    );
  }

  static void showError(BuildContext context, String message) {
    _show(
      context,
      message,
      icon: PhosphorIconsFill.warningCircle,
      backgroundColor: const Color(0xFFB42318),
      textColor: Colors.white,
    );
  }

  static void showInfo(BuildContext context, String message) {
    _show(
      context,
      message,
      icon: PhosphorIconsFill.info,
      backgroundColor: const Color(0xFF344054),
      textColor: Colors.white,
    );
  }

  static void _show(
    BuildContext context,
    String message, {
    required IconData icon,
    required Color backgroundColor,
    required Color textColor,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: textColor, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor.withOpacity(0.9), 
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}