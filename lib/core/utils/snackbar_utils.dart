// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class AppSnackbars {
  static void showSuccess(String message) {
    _show(
      message,
      icon: PhosphorIconsFill.checkCircle,
      backgroundColor: const Color.fromARGB(255, 0, 180, 0),
      textColor: Colors.white,
    );
  }

  static void showError(String message) {
    _show(
      message,
      icon: PhosphorIconsFill.warningCircle,
      backgroundColor: const Color(0xFFB42318),
      textColor: Colors.white,
    );
  }

  static void showInfo(String message) {
    _show(
      message,
      icon: PhosphorIconsFill.info,
      backgroundColor: const Color(0xFF344054),
      textColor: Colors.white,
    );
  }

  static void _show(
    String message, {
    required IconData icon,
    required Color backgroundColor,
    required Color textColor,
  }) {
    final messenger = rootScaffoldMessengerKey.currentState;
    if (messenger == null) return;

    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
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