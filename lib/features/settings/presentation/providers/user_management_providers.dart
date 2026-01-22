import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warehousesys/features/auth/data/models/user_model.dart';
import 'package:warehousesys/features/stock/presentation/providers/stock_providers.dart';

final usersListProvider = FutureProvider.autoDispose<List<User>>((ref) async {
  final repo = ref.watch(stockRepositoryProvider);
  return repo.getUsers();
});

final rolesListProvider = FutureProvider.autoDispose<List<Role>>((ref) async {
  final repo = ref.watch(stockRepositoryProvider);
  return repo.getRoles();
});

class UserManagementController extends StateNotifier<AsyncValue<void>> {
  final Ref ref;
  UserManagementController(this.ref) : super(const AsyncValue.data(null));

  Future<void> createUser({required String name, required String email, required String password, required int roleId}) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(stockRepositoryProvider).createUser(name: name, email: email, password: password, roleId: roleId);
      ref.invalidate(usersListProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteUser(int userId) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(stockRepositoryProvider).deleteUser(userId);
      ref.invalidate(usersListProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> createRole(String name, List<String> permissions) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(stockRepositoryProvider).createRole(name: name, permissions: permissions);
      ref.invalidate(rolesListProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateUser({
    required int userId,
    required String name,
    required String email,
    String? password,
    required int roleId,
  }) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(stockRepositoryProvider).updateUser(
        userId: userId,
        name: name,
        email: email,
        password: password,
        roleId: roleId,
      );
      ref.invalidate(usersListProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateRole(int roleId, String name, List<String> permissions) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(stockRepositoryProvider).updateRole(
        roleId: roleId,
        name: name,
        permissions: permissions,
      );
      ref.invalidate(rolesListProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteRole(int roleId) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(stockRepositoryProvider).deleteRole(roleId);
      ref.invalidate(rolesListProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final userManagementProvider = StateNotifierProvider<UserManagementController, AsyncValue<void>>((ref) {
  return UserManagementController(ref);
});