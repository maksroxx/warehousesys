import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:warehousesys/core/theme/app_theme.dart';
import 'package:warehousesys/features/auth/data/models/user_model.dart';
import 'package:warehousesys/features/settings/presentation/providers/user_management_providers.dart';

class UsersRolesManager extends ConsumerStatefulWidget {
  final int initialTab;
  const UsersRolesManager({super.key, this.initialTab = 0});

  @override
  ConsumerState<UsersRolesManager> createState() => _UsersRolesManagerState();
}

class _UsersRolesManagerState extends ConsumerState<UsersRolesManager>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialTab,
    );
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
            content: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.white),
                const SizedBox(width: 8),
                Expanded(child: Text('Ошибка: ${next.error}')),
              ],
            ),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Управление доступом',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textDarkColor,
              ),
            ),
            IconButton(
              icon: const Icon(PhosphorIconsRegular.x),
              onPressed: () => Navigator.of(context).pop(),
              tooltip: "Закрыть",
            ),
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
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            tabs: const [
              Tab(text: "Пользователи", icon: Icon(PhosphorIconsRegular.users)),
              Tab(
                text: "Роли и Права",
                icon: Icon(PhosphorIconsRegular.lockKey),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [_UsersListTab(), _RolesListTab()],
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Toolbar
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Список сотрудников",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: textHeaderColor,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () => _showUserDialog(context),
              icon: const Icon(PhosphorIconsBold.plus, size: 16),
              label: const Text('Добавить сотрудника'),
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
            ),
          ],
        ),
        const SizedBox(height: 16),

        // List
        Expanded(
          child: usersAsync.when(
            data: (users) {
              if (users.isEmpty) {
                return _buildEmptyState();
              }
              return ListView.separated(
                itemCount: users.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final user = users[index];
                  return _buildUserTile(context, ref, user);
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Ошибка загрузки: $err')),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            PhosphorIconsRegular.userList,
            size: 64,
            color: textGreyColor.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          const Text(
            "Нет пользователей",
            style: TextStyle(color: textGreyColor),
          ),
        ],
      ),
    );
  }

  Widget _buildUserTile(BuildContext context, WidgetRef ref, User user) {
    final isAdmin = user.role.name == 'admin';

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      hoverColor: hoverColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      leading: CircleAvatar(
        backgroundColor: isAdmin
            ? Colors.purple.withOpacity(0.1)
            : primaryColor.withOpacity(0.1),
        radius: 20,
        child: Text(
          user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
          style: TextStyle(
            color: isAdmin ? Colors.purple : primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
        user.name,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: textDarkColor,
        ),
      ),
      subtitle: Text(
        user.email,
        style: const TextStyle(color: textGreyColor, fontSize: 13),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: isAdmin
                  ? Colors.purple.withOpacity(0.1)
                  : Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isAdmin
                    ? Colors.purple.withOpacity(0.2)
                    : Colors.blue.withOpacity(0.2),
              ),
            ),
            child: Text(
              user.role.name,
              style: TextStyle(
                color: isAdmin ? Colors.purple : Colors.blue,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Actions
          IconButton(
            icon: const Icon(
              PhosphorIconsRegular.pencilSimple,
              size: 20,
              color: textGreyColor,
            ),
            tooltip: "Редактировать",
            onPressed: () => _showUserDialog(context, user: user),
          ),
          IconButton(
            icon: const Icon(
              PhosphorIconsRegular.trash,
              size: 20,
              color: Colors.redAccent,
            ),
            tooltip: "Удалить",
            onPressed: () => _confirmDeleteUser(context, ref, user),
          ),
        ],
      ),
    );
  }

  void _showUserDialog(BuildContext context, {User? user}) {
    showDialog(
      context: context,
      builder: (ctx) => _UserDialog(user: user),
    );
  }

  void _confirmDeleteUser(BuildContext context, WidgetRef ref, User user) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Удаление пользователя"),
        content: Text(
          "Вы уверены, что хотите удалить ${user.name}? Доступ к системе будет закрыт.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Отмена"),
          ),
          FilledButton(
            onPressed: () {
              ref.read(userManagementProvider.notifier).deleteUser(user.id);
              Navigator.pop(ctx);
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Удалить"),
          ),
        ],
      ),
    );
  }
}

class _UserDialog extends ConsumerStatefulWidget {
  final User? user;
  const _UserDialog({this.user});

  @override
  ConsumerState<_UserDialog> createState() => _UserDialogState();
}

class _UserDialogState extends ConsumerState<_UserDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameCtrl;
  late TextEditingController _emailCtrl;
  final _passCtrl = TextEditingController();

  Role? _selectedRole;
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.user?.name ?? '');
    _emailCtrl = TextEditingController(text: widget.user?.email ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.user != null;
    final rolesAsync = ref.watch(rolesListProvider);

    return AlertDialog(
      title: Text(isEdit ? "Редактирование профиля" : "Новый пользователь"),
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      content: SizedBox(
        width: 420,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel("Имя сотрудника"),
                TextFormField(
                  controller: _nameCtrl,
                  decoration: const InputDecoration(hintText: "Иван Иванов"),
                  validator: (v) => v!.isEmpty ? "Введите имя" : null,
                ),
                const SizedBox(height: 16),

                _buildLabel("Email (Логин)"),
                TextFormField(
                  controller: _emailCtrl,
                  decoration: const InputDecoration(
                    hintText: "user@example.com",
                  ),
                  validator: (v) => v!.isEmpty ? "Введите email" : null,
                ),
                const SizedBox(height: 16),

                _buildLabel(isEdit ? "Новый пароль (опционально)" : "Пароль"),
                TextFormField(
                  controller: _passCtrl,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    hintText: isEdit ? "••••••" : "Придумайте пароль",
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure
                            ? PhosphorIconsRegular.eye
                            : PhosphorIconsRegular.eyeSlash,
                      ),
                      onPressed: () => setState(() => _isObscure = !_isObscure),
                    ),
                  ),
                  validator: (v) {
                    if (!isEdit && (v == null || v.isEmpty))
                      return "Введите пароль";
                    if (v != null && v.isNotEmpty && v.length < 4)
                      return "Минимум 4 символа";
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                _buildLabel("Роль"),
                rolesAsync.when(
                  data: (roles) {
                    // Pre-select role on edit
                    if (_selectedRole == null && isEdit) {
                      try {
                        _selectedRole = roles.firstWhere(
                          (r) => r.id == widget.user!.role.id,
                        );
                      } catch (_) {}
                    }
                    return DropdownButtonFormField<Role>(
                      value: _selectedRole,
                      decoration: const InputDecoration(
                        hintText: "Выберите роль",
                      ),
                      items: roles
                          .map(
                            (r) =>
                                DropdownMenuItem(value: r, child: Text(r.name)),
                          )
                          .toList(),
                      onChanged: (v) => setState(() => _selectedRole = v),
                      validator: (v) => v == null ? "Выберите роль" : null,
                    );
                  },
                  loading: () => const LinearProgressIndicator(minHeight: 2),
                  error: (e, s) => Text(
                    "Ошибка: $e",
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actionsPadding: const EdgeInsets.all(24),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Отмена", style: TextStyle(color: textGreyColor)),
        ),
        ElevatedButton(
          onPressed: () => _submit(),
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(isEdit ? "Сохранить" : "Создать"),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 13,
          color: textHeaderColor,
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate() && _selectedRole != null) {
      if (widget.user != null) {
        // Update
        await ref
            .read(userManagementProvider.notifier)
            .updateUser(
              userId: widget.user!.id,
              name: _nameCtrl.text,
              email: _emailCtrl.text,
              password: _passCtrl.text.isEmpty ? null : _passCtrl.text,
              roleId: _selectedRole!.id,
            );
      } else {
        // Create
        await ref
            .read(userManagementProvider.notifier)
            .createUser(
              name: _nameCtrl.text,
              email: _emailCtrl.text,
              password: _passCtrl.text,
              roleId: _selectedRole!.id,
            );
      }
      if (mounted) Navigator.pop(context);
    }
  }
}

class _RolesListTab extends ConsumerWidget {
  const _RolesListTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rolesAsync = ref.watch(rolesListProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Группы и права доступа",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: textHeaderColor,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () => _showRoleDialog(context),
              icon: const Icon(PhosphorIconsBold.plus, size: 16),
              label: const Text('Создать роль'),
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
            ),
          ],
        ),
        const SizedBox(height: 16),
        Expanded(
          child: rolesAsync.when(
            data: (roles) => ListView.builder(
              itemCount: roles.length,
              itemBuilder: (context, index) {
                final role = roles[index];
                return _RoleCard(role: role, ref: ref);
              },
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Ошибка: $err')),
          ),
        ),
      ],
    );
  }

  void _showRoleDialog(BuildContext context, {Role? role}) {
    showDialog(
      context: context,
      builder: (ctx) => _RoleDialog(role: role),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final Role role;
  final WidgetRef ref;
  const _RoleCard({required this.role, required this.ref});

  @override
  Widget build(BuildContext context) {
    final isAdmin = role.name == 'admin';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          title: Row(
            children: [
              Icon(
                PhosphorIconsFill.shield,
                color: isAdmin ? Colors.purple : primaryColor,
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                role.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: backgroundLightColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  "${role.permissions.length} прав",
                  style: const TextStyle(fontSize: 11, color: textGreyColor),
                ),
              ),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(color: borderColor),
                  const SizedBox(height: 12),
                  if (role.permissions.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: role.permissions
                          .map(
                            (p) => Chip(
                              label: Text(
                                p,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: textHeaderColor,
                                ),
                              ),
                              backgroundColor: Colors.transparent,
                              side: const BorderSide(color: borderColor),
                              padding: EdgeInsets.zero,
                              labelPadding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              visualDensity: VisualDensity.compact,
                            ),
                          )
                          .toList(),
                    )
                  else
                    const Text(
                      "Нет назначенных прав",
                      style: TextStyle(
                        color: textGreyColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),

                  const SizedBox(height: 16),

                  if (!isAdmin)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton.icon(
                          onPressed: () => _showEditDialog(context),
                          icon: const Icon(
                            PhosphorIconsRegular.pencilSimple,
                            size: 16,
                          ),
                          label: const Text("Изменить права"),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: textHeaderColor,
                            side: const BorderSide(color: borderColor),
                          ),
                        ),
                        const SizedBox(width: 8),
                        OutlinedButton.icon(
                          onPressed: () => _confirmDelete(context),
                          icon: const Icon(
                            PhosphorIconsRegular.trash,
                            size: 16,
                            color: Colors.red,
                          ),
                          label: const Text(
                            "Удалить роль",
                            style: TextStyle(color: Colors.red),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.redAccent),
                          ),
                        ),
                      ],
                    )
                  else
                    Container(
                      padding: const EdgeInsets.all(8),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.lock, size: 14, color: Colors.orange),
                          SizedBox(width: 8),
                          Text(
                            "Системная роль администратора не может быть изменена",
                            style: TextStyle(fontSize: 12, color: Colors.brown),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => _RoleDialog(role: role),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Удаление роли"),
        content: const Text(
          "Вы уверены? Если у этой роли есть активные пользователи, это может вызвать ошибки доступа.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Отмена"),
          ),
          FilledButton(
            onPressed: () {
              ref.read(userManagementProvider.notifier).deleteRole(role.id);
              Navigator.pop(ctx);
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Удалить"),
          ),
        ],
      ),
    );
  }
}

class _RoleDialog extends ConsumerStatefulWidget {
  final Role? role;
  const _RoleDialog({this.role});

  @override
  ConsumerState<_RoleDialog> createState() => _RoleDialogState();
}

class _RoleDialogState extends ConsumerState<_RoleDialog> {
  final _nameCtrl = TextEditingController();

  final Map<String, bool> _permissions = {
    'view_dashboard': false,
    'view_inventory': false,
    'create_document': false,
    'manage_users': false,
    'view_reports': false,
    'view_stock': false,
    'approve_document': false,
    'view_counterparties': false,
  };

  final Map<String, String> _permLabels = {
    'view_dashboard': 'Просмотр Дашборда',
    'view_inventory': 'Просмотр Остатков',
    'create_document': 'Создание Документов',
    'manage_users': 'Управление Пользователями (Админ)',
    'view_reports': 'Просмотр Отчетов',
    'view_stock': 'Просмотр Склада',
    'approve_document': 'Проведение Документов',
    'view_counterparties': 'Просмотр Контрагентов',
  };

  @override
  void initState() {
    super.initState();
    if (widget.role != null) {
      _nameCtrl.text = widget.role!.name;
      for (var p in widget.role!.permissions) {
        if (_permissions.containsKey(p)) {
          _permissions[p] = true;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.role != null;

    return AlertDialog(
      title: Text(isEdit ? "Редактирование роли" : "Создание роли"),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      content: SizedBox(
        width: 500,
        height: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Название",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: textHeaderColor,
              ),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(hintText: "Например: manager"),
            ),
            const SizedBox(height: 24),
            const Text(
              "Права доступа",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: textHeaderColor,
              ),
            ),
            const SizedBox(height: 8),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: borderColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: _permissions.keys.map((perm) {
                    return CheckboxListTile(
                      title: Text(
                        _permLabels[perm] ?? perm,
                        style: const TextStyle(fontSize: 14),
                      ),
                      value: _permissions[perm],
                      activeColor: primaryColor,
                      onChanged: (val) =>
                          setState(() => _permissions[perm] = val!),
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      dense: true,
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
      actionsPadding: const EdgeInsets.all(24),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Отмена", style: TextStyle(color: textGreyColor)),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_nameCtrl.text.isNotEmpty) {
              final selectedPerms = _permissions.entries
                  .where((e) => e.value)
                  .map((e) => e.key)
                  .toList();

              if (isEdit) {
                await ref
                    .read(userManagementProvider.notifier)
                    .updateRole(widget.role!.id, _nameCtrl.text, selectedPerms);
              } else {
                await ref
                    .read(userManagementProvider.notifier)
                    .createRole(_nameCtrl.text, selectedPerms);
              }
              if (mounted) Navigator.pop(context);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(isEdit ? "Сохранить" : "Создать"),
        ),
      ],
    );
  }
}
