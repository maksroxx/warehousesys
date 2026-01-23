import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:warehousesys/core/theme/app_theme.dart';
import 'package:warehousesys/core/utils/dialog_utils.dart';
import 'package:warehousesys/core/widgets/styled_hover_card.dart';
import 'package:warehousesys/features/auth/data/models/user_model.dart';
import 'package:warehousesys/features/settings/presentation/providers/user_management_providers.dart';

class UsersRolesManager extends ConsumerStatefulWidget {
  final int initialTab;
  const UsersRolesManager({super.key, this.initialTab = 0});

  @override
  ConsumerState<UsersRolesManager> createState() => _UsersRolesManagerState();
}

class _UsersRolesManagerState extends ConsumerState<UsersRolesManager> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: widget.initialTab);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(userManagementProvider, (prev, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка: ${next.error}'),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Управление доступом',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textDarkColor),
            ),
            IconButton(
              icon: const Icon(PhosphorIconsRegular.x),
              onPressed: () => Navigator.of(context).pop(),
              tooltip: "Закрыть",
            )
          ],
        ),
        const SizedBox(height: 24),
        
        Container(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: borderColor)),
          ),
          child: TabBar(
            controller: _tabController,
            labelColor: primaryColor,
            unselectedLabelColor: textGreyColor,
            indicatorColor: primaryColor,
            indicatorWeight: 3,
            labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            tabs: const [
              Tab(text: "Пользователи", icon: Icon(PhosphorIconsRegular.users)),
              Tab(text: "Роли и Права", icon: Icon(PhosphorIconsRegular.lockKey)),
            ],
          ),
        ),
        const SizedBox(height: 24),

        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              _UsersListTab(),
              _RolesListTab(),
            ],
          ),
        ),
      ],
    );
  }
}

class _UsersListTab extends ConsumerWidget {
  const _UsersListTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(usersListProvider);

    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton.icon(
            onPressed: () => _openUserDialog(context, ref),
            icon: const Icon(PhosphorIconsBold.plus, size: 16),
            label: const Text('Добавить сотрудника'),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor, 
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: usersAsync.when(
            data: (users) {
              if (users.isEmpty) return const Center(child: Text("Список пользователей пуст"));
              
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  final isAdmin = user.role.name == 'admin';
                  
                  return StyledHoverCard(
                    title: user.name,
                    subtitle: user.email,
                    leading: CircleAvatar(
                      backgroundColor: isAdmin ? Colors.purple.withOpacity(0.1) : primaryColor.withOpacity(0.1),
                      child: Text(
                        user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                        style: TextStyle(
                          color: isAdmin ? Colors.purple : primaryColor,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isAdmin ? Colors.purple.withOpacity(0.1) : Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isAdmin ? Colors.purple.withOpacity(0.2) : Colors.blue.withOpacity(0.2)
                        ),
                      ),
                      child: Text(
                        user.role.name,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isAdmin ? Colors.purple : Colors.blue
                        ),
                      ),
                    ),
                    onEdit: () => _openUserDialog(context, ref, user: user),
                    onDelete: () => showBeautifulDeleteDialog(
                      context: context,
                      title: "Удалить сотрудника?",
                      content: "Доступ в систему для пользователя ${user.email} будет закрыт.",
                      itemName: user.name,
                      onDelete: () async {
                        await ref.read(userManagementProvider.notifier).deleteUser(user.id);
                      }
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Ошибка: $err')),
          ),
        ),
      ],
    );
  }

  void _openUserDialog(BuildContext context, WidgetRef ref, {User? user}) {
    final formKey = GlobalKey<FormState>();
    final nameCtrl = TextEditingController(text: user?.name ?? '');
    final emailCtrl = TextEditingController(text: user?.email ?? '');
    final passCtrl = TextEditingController();
    Role? selectedRole;
    
    final isEdit = user != null;

    showStyledFormDialog(
      context: context,
      title: isEdit ? "Редактирование профиля" : "Новый сотрудник",
      icon: PhosphorIconsRegular.user,
      saveLabel: isEdit ? "Сохранить" : "Создать",
      onSave: () async {
        if (formKey.currentState!.validate() && selectedRole != null) {
          if (isEdit) {
            await ref.read(userManagementProvider.notifier).updateUser(
              userId: user.id,
              name: nameCtrl.text,
              email: emailCtrl.text,
              password: passCtrl.text.isEmpty ? null : passCtrl.text,
              roleId: selectedRole!.id,
            );
          } else {
            await ref.read(userManagementProvider.notifier).createUser(
              name: nameCtrl.text,
              email: emailCtrl.text,
              password: passCtrl.text,
              roleId: selectedRole!.id,
            );
          }
          if (context.mounted) Navigator.pop(context);
        }
      },
      content: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel("ФИО"),
            TextFormField(
              controller: nameCtrl,
              validator: (v) => v!.isEmpty ? "Введите имя" : null,
              decoration: const InputDecoration(hintText: "Иванов Иван"),
            ),
            const SizedBox(height: 16),
            
            _buildLabel("Email (Логин)"),
            TextFormField(
              controller: emailCtrl,
              validator: (v) => v!.isEmpty ? "Введите email" : null,
              decoration: const InputDecoration(hintText: "user@company.com"),
            ),
            const SizedBox(height: 16),
            
            _buildLabel(isEdit ? "Новый пароль (оставьте пустым, если не меняете)" : "Пароль"),
            TextFormField(
              controller: passCtrl,
              obscureText: true,
              validator: (v) {
                if (!isEdit && (v == null || v.length < 4)) return "Минимум 4 символа";
                return null;
              },
              decoration: const InputDecoration(hintText: "••••••"),
            ),
            const SizedBox(height: 16),
            
            _buildLabel("Роль"),
            Consumer(
              builder: (ctx, ref, _) {
                final rolesAsync = ref.watch(rolesListProvider);
                return rolesAsync.when(
                  data: (roles) {
                    // Pre-select role logic
                    if (isEdit && selectedRole == null) {
                      try {
                        selectedRole = roles.firstWhere((r) => r.id == user.role.id);
                      } catch (_) {}
                    }
                    return DropdownButtonFormField<Role>(
                      initialValue: selectedRole,
                      decoration: const InputDecoration(hintText: "Выберите роль"),
                      items: roles.map((r) => DropdownMenuItem(value: r, child: Text(r.name))).toList(),
                      onChanged: (v) => selectedRole = v,
                      validator: (v) => v == null ? "Выберите роль" : null,
                    );
                  },
                  loading: () => const LinearProgressIndicator(),
                  error: (e, s) => Text("Ошибка загрузки ролей: $e", style: const TextStyle(color: Colors.red)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _RolesListTab extends ConsumerWidget {
  const _RolesListTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rolesAsync = ref.watch(rolesListProvider);

    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton.icon(
            onPressed: () => _openRoleDialog(context, ref),
            icon: const Icon(PhosphorIconsBold.plus, size: 16),
            label: const Text('Создать роль'),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor, 
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: rolesAsync.when(
            data: (roles) => ListView.builder(
              itemCount: roles.length,
              itemBuilder: (context, index) {
                final role = roles[index];
                final isAdmin = role.name == 'admin';

                return StyledHoverCard(
                  title: role.name,
                  leading: Icon(PhosphorIconsFill.shield, color: isAdmin ? Colors.purple : primaryColor, size: 32),
                  subtitle: role.permissions.isEmpty 
                      ? "Нет прав" 
                      : "${role.permissions.length} активных прав",
                  showActions: !isAdmin,
                  onEdit: () => _openRoleDialog(context, ref, role: role),
                  onDelete: () => showBeautifulDeleteDialog(
                    context: context,
                    title: "Удалить роль?",
                    content: "Убедитесь, что нет активных пользователей с этой ролью.",
                    itemName: role.name,
                    onDelete: () async {
                      await ref.read(userManagementProvider.notifier).deleteRole(role.id);
                    }
                  ),
                );
              },
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Ошибка: $err')),
          ),
        ),
      ],
    );
  }

  void _openRoleDialog(BuildContext context, WidgetRef ref, {Role? role}) {
    final nameCtrl = TextEditingController(text: role?.name ?? '');
    final isEdit = role != null;
    
    final Map<String, bool> permissions = {
      'view_dashboard': false,
      'view_inventory': false,
      'create_document': false,
      'approve_document': false,
      'manage_users': false,
      'view_reports': false,
      'view_stock': false,
      'manage_warehouses': false,
      'manage_categories': false,
      'view_counterparties': false,
    };

    final Map<String, String> permLabels = {
      'view_dashboard': 'Просмотр Дашборда',
      'view_inventory': 'Просмотр Остатков',
      'create_document': 'Создание Документов',
      'approve_document': 'Проведение Документов',
      'manage_users': 'Управление Пользователями (Админ)',
      'view_reports': 'Просмотр Отчетов',
      'view_stock': 'Просмотр Склада',
      'manage_warehouses': 'Управление Складами',
      'manage_categories': 'Управление Категориями',
      'view_counterparties': 'Просмотр Контрагентов',
    };

    if (isEdit) {
      for (var p in role.permissions) {
        if (permissions.containsKey(p)) permissions[p] = true;
      }
    }

    showStyledFormDialog(
      context: context,
      title: isEdit ? "Настройка роли" : "Новая роль",
      icon: PhosphorIconsRegular.shieldCheck,
      saveLabel: isEdit ? "Сохранить" : "Создать",
      onSave: () async {
        if (nameCtrl.text.isNotEmpty) {
          final selectedPerms = permissions.entries
              .where((e) => e.value)
              .map((e) => e.key)
              .toList();
          
          if (isEdit) {
            await ref.read(userManagementProvider.notifier).updateRole(
              role.id, nameCtrl.text, selectedPerms
            );
          } else {
            await ref.read(userManagementProvider.notifier).createRole(
              nameCtrl.text, selectedPerms
            );
          }
          if (context.mounted) Navigator.pop(context);
        }
      },
      content: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel("Название роли"),
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(hintText: "Например: manager"),
              ),
              const SizedBox(height: 20),
              _buildLabel("Права доступа"),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: borderColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: permissions.keys.map((key) => CheckboxListTile(
                    title: Text(permLabels[key] ?? key, style: const TextStyle(fontSize: 14)),
                    value: permissions[key],
                    activeColor: primaryColor,
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    onChanged: (val) => setState(() => permissions[key] = val!),
                  )).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

Widget _buildLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: textHeaderColor)),
  );
}