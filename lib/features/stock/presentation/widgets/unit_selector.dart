// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:warehousesys/core/theme/app_theme.dart';
import 'package:warehousesys/core/utils/snackbar_utils.dart';
import 'package:warehousesys/features/stock/data/models/filters.dart';
import 'package:warehousesys/features/stock/presentation/providers/stock_providers.dart';

class UnitSelector extends ConsumerWidget {
  final Unit? selectedUnit;
  final ValueChanged<Unit?> onChanged;

  const UnitSelector({
    super.key,
    required this.selectedUnit,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unitsAsync = ref.watch(unitsProvider);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: unitsAsync.when(
            data: (units) => DropdownButtonFormField<Unit>(
              value: selectedUnit,
              decoration: const InputDecoration(
                labelText: "Ед. измерения",
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
              ),
              items: units
                  .map((u) => DropdownMenuItem(value: u, child: Text(u.name)))
                  .toList(),
              onChanged: onChanged,
              validator: (v) => v == null ? "Выберите ед. изм." : null,
            ),
            loading: () => const LinearProgressIndicator(),
            error: (e, s) => Text("Ошибка: $e"),
          ),
        ),
        const SizedBox(width: 8),
        Tooltip(
          message: "Создать новую единицу",
          child: InkWell(
            onTap: () => _showCreateUnitDialog(context, ref),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: primaryColor.withOpacity(0.3)),
              ),
              child: const Icon(
                PhosphorIconsBold.plus,
                color: primaryColor,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showCreateUnitDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Row(
          children: [
            Icon(PhosphorIconsRegular.ruler, color: primaryColor),
            SizedBox(width: 12),
            Text(
              "Новая единица",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        content: SizedBox(
          width: 350,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Название",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: textHeaderColor,
                  ),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: "Например: шт, кг, литр, коробка",
                  ),
                  autofocus: true,
                  validator: (v) => v!.isEmpty ? "Введите название" : null,
                ),
              ],
            ),
          ),
        ),
        actionsPadding: const EdgeInsets.all(24),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Отмена", style: TextStyle(color: textGreyColor)),
          ),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                try {
                  await ref
                      .read(stockRepositoryProvider)
                      .createUnit(controller.text);
                  ref.invalidate(unitsProvider);
                  if (context.mounted) Navigator.pop(ctx);
                } catch (e) {
                  AppSnackbars.showError("Ошибка: $e");
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: const Text("Создать"),
          ),
        ],
      ),
    );
  }
}
