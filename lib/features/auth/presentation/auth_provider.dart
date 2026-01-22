import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warehousesys/core/network/dio_provider.dart';
import 'package:warehousesys/core/network/token_storage.dart';
import 'package:warehousesys/features/auth/data/models/user_model.dart';

class AuthState {
  final User? user;
  final bool isAuthenticated;
  final bool isLoading;
  final String? error;

  AuthState({
    this.user,
    this.isAuthenticated = false,
    this.isLoading = true,
    this.error,
  });
}

class AuthNotifier extends StateNotifier<AuthState> {
  final Dio _dio;

  AuthNotifier(this._dio) : super(AuthState()) {
    _init();
  }

  Future<void> _init() async {
    try {
      final token = await TokenStorage.getToken();

      if (token != null) {
        final response = await _dio.get('/auth/me');
        final user = User.fromJson(response.data);
        state = AuthState(user: user, isAuthenticated: true, isLoading: false);
      } else {
        state = AuthState(isAuthenticated: false, isLoading: false);
      }
    } catch (e) {
      print('Auth Init Error: $e');
      await logout();
    }
  }

  Future<void> login(String email, String password) async {
    state = AuthState(isLoading: true);
    try {
      final response = await _dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });

      final token = response.data['token'];
      final userData = response.data['user'];
      final user = User.fromJson(userData);

      await TokenStorage.saveToken(token);

      state = AuthState(user: user, isAuthenticated: true, isLoading: false);
    } catch (e) {
      state = AuthState(isAuthenticated: false, isLoading: false, error: e.toString());
      rethrow;
    }
  }

  Future<void> logout() async {
    await TokenStorage.deleteToken();
    state = AuthState(isAuthenticated: false, isLoading: false);
  }

  bool hasPermission(String permission) {
    if (state.user == null) return false;
    if (state.user!.role.name == 'admin') return true;
    return state.user!.role.permissions.contains(permission);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthNotifier(dio);
});