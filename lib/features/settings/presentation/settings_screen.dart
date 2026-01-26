// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:warehousesys/core/theme/app_theme.dart';
import 'package:warehousesys/core/utils/dialog_utils.dart';
import 'package:warehousesys/core/utils/snackbar_utils.dart';
import 'package:warehousesys/features/auth/presentation/auth_provider.dart';
import 'package:warehousesys/features/settings/presentation/users_roles_manager.dart';
import 'package:warehousesys/features/settings/presentation/warehouses_categories_manager.dart';
import 'package:warehousesys/features/stock/presentation/providers/stock_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasUserManagePerm = ref
        .watch(authProvider.notifier)
        .hasPermission('manage_users');
    final hasWarehousePerm = ref
        .watch(authProvider.notifier)
        .hasPermission('manage_warehouses');
    final hasCategoryPerm = ref
        .watch(authProvider.notifier)
        .hasPermission('manage_categories');

    final List<Widget> settingsWidgets = [
      if (hasUserManagePerm)
        _SettingsWidgetCard(
          title: 'Пользователи и Права',
          icon: PhosphorIconsRegular.users,
          description:
              'Управление ролями сотрудников и настройка доступа к модулям системы.',
          points: const [
            'Создание и удаление учетных записей',
            'Настройка ролей (Администратор, Кладовщик)',
            'Разграничение прав доступа',
          ],
          actions: [
            _WidgetAction(
              label: 'Пользователи',
              onTap: () => _openUserManager(context, initialTab: 0),
              isPrimary: false,
            ),
            _WidgetAction(
              label: 'Роли',
              onTap: () => _openUserManager(context, initialTab: 1),
              isPrimary: true,
            ),
          ],
        ),

      if (hasWarehousePerm)
        _SettingsWidgetCard(
          title: 'Склады',
          icon: PhosphorIconsRegular.warehouse,
          description: 'Добавление и удаление складских помещений.',
          points: const ['Список активных складов', 'Адреса и реквизиты'],
          actions: [
            _WidgetAction(
              label: 'Управление',
              onTap: () => showDialog(
                context: context,
                builder: (_) => const WarehousesManagerDialog(),
              ),
              isPrimary: true,
            ),
          ],
        ),

      if (hasCategoryPerm)
        _SettingsWidgetCard(
          title: 'Категории товаров',
          icon: PhosphorIconsRegular.tag,
          description: 'Справочник категорий для группировки номенклатуры.',
          points: const ['Создание новых категорий', 'Редактирование названий'],
          actions: [
            _WidgetAction(
              label: 'Редактировать',
              onTap: () => showDialog(
                context: context,
                builder: (_) => const CategoriesManagerDialog(),
              ),
              isPrimary: false,
            ),
          ],
        ),

      _SettingsWidgetCard(
        title: 'Резервное копирование',
        icon: PhosphorIconsRegular.database,
        description: 'Сохранение и восстановление базы данных.',
        points: const [
          'Скачать полную копию базы (.db)',
          'Восстановить данные из файла',
        ],
        actions: [
          _WidgetAction(
            label: 'Создать бэкап',
            isPrimary: true,
            onTap: () async {
              try {
                final bytes = await ref
                    .read(stockRepositoryProvider)
                    .backupDatabase();
                final name =
                    "FlowKeeper_Backup_${DateFormat('yyyyMMdd_HHmm').format(DateTime.now())}";

                if (!kIsWeb && (Platform.isMacOS || Platform.isWindows)) {
                  await FileSaver.instance.saveFile(
                    name: name,
                    bytes: bytes,
                    ext: 'db',
                    mimeType: MimeType.other,
                  );
                } else {
                  await FileSaver.instance.saveFile(
                    name: name,
                    bytes: bytes,
                    ext: 'db',
                    mimeType: MimeType.other,
                  );
                }

                if (context.mounted) {
                  AppSnackbars.showSuccess("Бэкап успешно сохранен");
                }
              } catch (e) {
                if (context.mounted) {
                  AppSnackbars.showError("Ошибка создания бэкапа: $e");
                }
              }
            },
          ),
          _WidgetAction(
            label: 'Восстановить',
            isPrimary: false,
            isDestructive: true,
            onTap: () async {
              showBeautifulDeleteDialog(
                context: context,
                title: "Восстановить базу?",
                confirmButtonText: "Восстановить",
                content:
                    "Текущие данные будут полностью заменены данными из файла. Это действие необратимо!",
                itemName: "Восстановление из файла",
                onDelete: () async {
                  final result = await FilePicker.platform.pickFiles(
                    type: FileType.any,
                    dialogTitle: "Выберите файл бэкапа (.db)",
                  );

                  if (result != null && result.files.single.path != null) {
                    final file = File(result.files.single.path!);

                    try {
                      await ref
                          .read(stockRepositoryProvider)
                          .restoreDatabase(file);

                      if (context.mounted) {
                        AppSnackbars.showSuccess(
                          "База восстановлена! Перезагрузка...",
                        );
                        await Future.delayed(const Duration(seconds: 2));
                        ref.read(authProvider.notifier).logout();
                      }
                    } catch (e) {
                      if (context.mounted) {
                        AppSnackbars.showError("Ошибка восстановления: $e");
                      }
                    }
                  }
                },
              );
            },
          ),
        ],
      ),

      _SettingsWidgetCard(
        title: 'Текущая сессия',
        icon: PhosphorIconsRegular.signOut,
        description: 'Управление текущим сеансом работы в системе.',
        points: const [
          'Безопасный выход из аккаунта',
          'Сброс локальных данных авторизации',
        ],
        actions: [
          _WidgetAction(
            label: 'Выйти из системы',
            onTap: () => ref.read(authProvider.notifier).logout(),
            isPrimary: false,
            isDestructive: true,
          ),
        ],
      ),
    ];

    return Scaffold(
      backgroundColor: backgroundLightColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Настройки системы',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: textDarkColor,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Управляйте конфигурацией приложения, пользователями и безопасностью.',
              style: TextStyle(fontSize: 16, color: textGreyColor),
            ),
            const SizedBox(height: 32),

            LayoutBuilder(
              builder: (context, constraints) {
                final int crossAxisCount = (constraints.maxWidth / 400)
                    .floor()
                    .clamp(1, 4);

                return GridView.count(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: 1.3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: settingsWidgets,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _openUserManager(BuildContext context, {int initialTab = 0}) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 900,
          height: 700,
          padding: const EdgeInsets.all(24),
          child: UsersRolesManager(initialTab: initialTab),
        ),
      ),
    );
  }
}

class _SettingsWidgetCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final String description;
  final List<String> points;
  final List<_WidgetAction> actions;

  const _SettingsWidgetCard({
    required this.title,
    required this.icon,
    required this.description,
    required this.points,
    required this.actions,
  });

  @override
  State<_SettingsWidgetCard> createState() => _SettingsWidgetCardState();
}

class _SettingsWidgetCardState extends State<_SettingsWidgetCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        transform: _isHovered
            ? Matrix4.translationValues(0, -4, 0)
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered ? primaryColor.withOpacity(0.3) : borderColor,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textDarkColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: backgroundLightColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(widget.icon, color: textHeaderColor, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Text(
              widget.description,
              style: const TextStyle(
                fontSize: 14,
                color: textHeaderColor,
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            const Divider(height: 1, color: borderColor),
            const SizedBox(height: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.points
                    .map(
                      (point) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 6.0, right: 8.0),
                              child: Icon(
                                Icons.circle,
                                size: 4,
                                color: textGreyColor,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                point,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: textGreyColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: widget.actions.map((action) {
                final isDestructive = action.isDestructive;
                final isPrimary = action.isPrimary;

                return Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: isPrimary
                      ? ElevatedButton(
                          onPressed: action.onTap,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(action.label),
                        )
                      : OutlinedButton(
                          onPressed: action.onTap,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: isDestructive
                                ? Colors.red
                                : textHeaderColor,
                            side: BorderSide(
                              color: isDestructive
                                  ? Colors.red.withOpacity(0.3)
                                  : borderColor,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(action.label),
                        ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _WidgetAction {
  final String label;
  final VoidCallback onTap;
  final bool isPrimary;
  final bool isDestructive;

  _WidgetAction({
    required this.label,
    required this.onTap,
    this.isPrimary = false,
    this.isDestructive = false,
  });
}
