import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:warehousesys/core/theme/app_theme.dart';
import 'package:warehousesys/core/utils/snackbar_utils.dart';
import 'package:warehousesys/features/auth/presentation/auth_provider.dart';
import 'package:warehousesys/features/stock/presentation/providers/stock_providers.dart';

class DatabaseSettingsDialog extends ConsumerStatefulWidget {
  const DatabaseSettingsDialog({super.key});

  @override
  ConsumerState<DatabaseSettingsDialog> createState() => _DatabaseSettingsDialogState();
}

class _DatabaseSettingsDialogState extends ConsumerState<DatabaseSettingsDialog> {
  String _selectedDriver = 'sqlite';
  
  final _hostCtrl = TextEditingController(text: 'localhost');
  final _portCtrl = TextEditingController(text: '5432');
  final _userCtrl = TextEditingController(text: 'postgres');
  final _passCtrl = TextEditingController();
  final _dbNameCtrl = TextEditingController(text: 'flowkeeper');
  
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Настройка базы данных", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _RadioCard(
                    title: "Локальная (SQLite)",
                    value: "sqlite",
                    groupValue: _selectedDriver,
                    icon: PhosphorIconsRegular.hardDrives,
                    onChanged: (v) => setState(() => _selectedDriver = v!),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _RadioCard(
                    title: "Сервер (PostgreSQL)",
                    value: "postgres",
                    groupValue: _selectedDriver,
                    icon: PhosphorIconsRegular.cloud,
                    onChanged: (v) => setState(() => _selectedDriver = v!),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),

            if (_selectedDriver == 'postgres') ...[
              const Text("Параметры подключения", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(flex: 3, child: _Field(label: "Хост", ctrl: _hostCtrl)),
                  const SizedBox(width: 12),
                  Expanded(flex: 1, child: _Field(label: "Порт", ctrl: _portCtrl)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _Field(label: "Пользователь", ctrl: _userCtrl)),
                  const SizedBox(width: 12),
                  Expanded(child: _Field(label: "Пароль", ctrl: _passCtrl, obscure: true)),
                ],
              ),
              const SizedBox(height: 12),
              _Field(label: "Имя базы данных", ctrl: _dbNameCtrl),
              const SizedBox(height: 24),
            ],

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _isLoading ? null : () => Navigator.pop(context),
                  child: const Text("Отмена", style: TextStyle(color: textGreyColor)),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _isLoading ? null : _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: _isLoading 
                    ? const SizedBox.square(dimension: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Text("Сохранить и Перезагрузить"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    setState(() => _isLoading = true);
    try {
      await ref.read(stockRepositoryProvider).switchDatabase(
        driver: _selectedDriver,
        host: _hostCtrl.text,
        port: _portCtrl.text,
        user: _userCtrl.text,
        password: _passCtrl.text,
        dbname: _dbNameCtrl.text,
      );

      if (mounted) {
        AppSnackbars.showSuccess("Настройки сохранены! Перезагрузка...");
        await Future.delayed(const Duration(seconds: 2));
        ref.read(authProvider.notifier).logout();
        
        if (mounted) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text("Требуется перезапуск"),
              content: const Text("Для применения настроек базы данных необходимо перезапустить приложение."),
              actions: [
                FilledButton(onPressed: () =>  exit(0), child: const Text("Закрыть приложение"))
              ],
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        AppSnackbars.showError("Ошибка: ${e.toString().replaceAll('Exception:', '')}");
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}

class _Field extends StatelessWidget {
  final String label;
  final TextEditingController ctrl;
  final bool obscure;
  const _Field({required this.label, required this.ctrl, this.obscure = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: textGreyColor)),
        const SizedBox(height: 4),
        TextFormField(controller: ctrl, obscureText: obscure),
      ],
    );
  }
}

class _RadioCard extends StatelessWidget {
  final String title;
  final String value;
  final String? groupValue;
  final IconData icon;
  final ValueChanged<String?> onChanged;

  const _RadioCard({required this.title, required this.value, required this.groupValue, required this.icon, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    return InkWell(
      onTap: () => onChanged(value),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withOpacity(0.05) : Colors.white,
          border: Border.all(color: isSelected ? primaryColor : borderColor, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? primaryColor : textGreyColor, size: 32),
            const SizedBox(height: 8),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: isSelected ? primaryColor : textDarkColor)),
          ],
        ),
      ),
    );
  }
}