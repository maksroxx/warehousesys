import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:warehousesys/core/theme/app_theme.dart';
import 'package:warehousesys/core/utils/dialog_utils.dart';
import 'package:warehousesys/core/utils/snackbar_utils.dart';
import 'package:warehousesys/core/widgets/styled_hover_card.dart';
import 'package:warehousesys/features/stock/data/models/filters.dart';
import 'package:warehousesys/features/stock/presentation/providers/stock_providers.dart';

class WarehousesManagerDialog extends ConsumerWidget {
  const WarehousesManagerDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final warehousesAsync = ref.watch(warehousesProvider);

    return _BaseManagerDialog(
      title: "Управление складами",
      icon: PhosphorIconsRegular.warehouse,
      onAdd: () => _showWarehouseDialog(context, ref),
      child: warehousesAsync.when(
        data: (list) {
          if (list.isEmpty) {
            return const Center(child: Text("Список складов пуст", style: TextStyle(color: textGreyColor)));
          }
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (ctx, i) {
              final wh = list[i];
              return StyledHoverCard(
                title: wh.name,
                subtitle: wh.address != null && wh.address!.isNotEmpty 
                    ? wh.address 
                    : "Адрес не указан",
                leading: const Icon(PhosphorIconsFill.warehouse, color: primaryColor, size: 32),
                
                onEdit: () => _showWarehouseDialog(context, ref, warehouse: wh),
                onDelete: () => _deleteWarehouse(context, ref, wh),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text("Ошибка загрузки: $e")),
      ),
    );
  }

  void _showWarehouseDialog(BuildContext context, WidgetRef ref, {Warehouse? warehouse}) {
    final nameCtrl = TextEditingController(text: warehouse?.name ?? '');
    final addrCtrl = TextEditingController(text: warehouse?.address ?? '');
    final isEdit = warehouse != null;
    final formKey = GlobalKey<FormState>();

    showStyledFormDialog(
      context: context,
      title: isEdit ? "Редактировать склад" : "Новый склад",
      icon: PhosphorIconsRegular.warehouse,
      saveLabel: isEdit ? "Сохранить" : "Создать",
      onSave: () async {
        if (formKey.currentState!.validate()) {
          try {
            if (isEdit) {
              AppSnackbars.showInfo("Редактирование складов пока не поддерживается API");
            } else {
              await ref.read(stockRepositoryProvider).createWarehouse(nameCtrl.text, addrCtrl.text);
            }
            
            ref.invalidate(warehousesProvider);
            if (context.mounted) Navigator.pop(context);
            
          } catch (e) {
            AppSnackbars.showError("Ошибка: $e");
          }
        }
      },
      content: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLabel("Название склада"),
            TextFormField(
              controller: nameCtrl,
              autofocus: true,
              validator: (v) => v!.isEmpty ? "Введите название" : null,
              decoration: const InputDecoration(hintText: "Например: Основной склад"),
            ),
            const SizedBox(height: 16),
            _buildLabel("Адрес"),
            TextFormField(
              controller: addrCtrl,
              decoration: const InputDecoration(hintText: "г. Москва, ул. Ленина, 1"),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteWarehouse(BuildContext context, WidgetRef ref, Warehouse wh) {
    showBeautifulDeleteDialog(
      context: context,
      title: "Удалить склад?",
      content: "Это действие необратимо. Убедитесь, что на складе нет остатков товаров.",
      itemName: wh.name,
      onDelete: () async {
        try {
          await ref.read(stockRepositoryProvider).deleteWarehouse(wh.id);
          ref.invalidate(warehousesProvider);
        } catch (e) {
          AppSnackbars.showError("Ошибка удаления: $e");
        }
      },
    );
  }
}

class CategoriesManagerDialog extends ConsumerWidget {
  const CategoriesManagerDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider);

    return _BaseManagerDialog(
      title: "Категории товаров",
      icon: PhosphorIconsRegular.tag,
      onAdd: () => _showCategoryDialog(context, ref),
      child: categoriesAsync.when(
        data: (list) {
          if (list.isEmpty) {
            return const Center(child: Text("Список категорий пуст", style: TextStyle(color: textGreyColor)));
          }
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (ctx, i) {
              final cat = list[i];
              return StyledHoverCard(
                title: cat.name,
                // subtitle: "ID: ${cat.id}",
                leading: const Icon(PhosphorIconsFill.tag, color: primaryColor, size: 32),
                
                // Действия
                onEdit: () => _showCategoryDialog(context, ref, category: cat),
                onDelete: () => _deleteCategory(context, ref, cat),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text("Ошибка: $e")),
      ),
    );
  }

  void _showCategoryDialog(BuildContext context, WidgetRef ref, {Category? category}) {
    final nameCtrl = TextEditingController(text: category?.name ?? '');
    final isEdit = category != null;
    final formKey = GlobalKey<FormState>();

    showStyledFormDialog(
      context: context,
      title: isEdit ? "Изменить категорию" : "Новая категория",
      icon: PhosphorIconsRegular.tag,
      saveLabel: isEdit ? "Сохранить" : "Создать",
      onSave: () async {
        if (formKey.currentState!.validate()) {
          try {
            if (isEdit) {
              await ref.read(stockRepositoryProvider).updateCategory(category.id, nameCtrl.text);
            } else {
              await ref.read(stockRepositoryProvider).createCategory(nameCtrl.text);
            }
            ref.invalidate(categoriesProvider);
            if (context.mounted) Navigator.pop(context);
          } catch (e) {
            AppSnackbars.showError("Ошибка: $e");
          }
        }
      },
      content: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLabel("Название категории"),
            TextFormField(
              controller: nameCtrl,
              autofocus: true,
              validator: (v) => v!.isEmpty ? "Введите название" : null,
              decoration: const InputDecoration(hintText: "Например: Электроника"),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteCategory(BuildContext context, WidgetRef ref, Category cat) {
    showBeautifulDeleteDialog(
      context: context,
      title: "Удалить категорию?",
      content: "Товары, привязанные к этой категории, могут потерять классификацию.",
      itemName: cat.name,
      onDelete: () async {
        try {
          await ref.read(stockRepositoryProvider).deleteCategory(cat.id);
          ref.invalidate(categoriesProvider);
        } catch (e) {
          AppSnackbars.showError("Ошибка удаления: $e");
        }
      },
    );
  }
}

Widget _buildLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: textHeaderColor)),
  );
}

class _BaseManagerDialog extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onAdd;
  final Widget child;

  const _BaseManagerDialog({required this.title, required this.icon, required this.onAdd, required this.child});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: backgroundLightColor,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 600,
        height: 700,
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                border: Border(bottom: BorderSide(color: borderColor)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(icon, size: 28, color: textDarkColor),
                      const SizedBox(width: 12),
                      Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: textDarkColor)),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: onAdd,
                  icon: const Icon(PhosphorIconsBold.plus, size: 16),
                  label: const Text("Добавить"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
            ),
            
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: child,
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}