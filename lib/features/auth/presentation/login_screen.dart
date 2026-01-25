// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warehousesys/core/theme/app_theme.dart';
import 'package:warehousesys/core/utils/snackbar_utils.dart';
import 'package:warehousesys/features/auth/presentation/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> _login() async {
    if (_isLoading) return;
    
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);
    FocusScope.of(context).unfocus();

    try {
      await ref.read(authProvider.notifier).login(
        _emailController.text.trim(),
        _passwordController.text,
      );      
    } catch (e) {
      _showErrorSnackbar(e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showErrorSnackbar(String error) {
    String errorMessage;
    final errorStr = error.toLowerCase();

    if (errorStr.contains("401") || errorStr.contains("unauthorized")) {
      errorMessage = "Неверный Email или пароль";
    } else if (errorStr.contains("connection") || errorStr.contains("socket")) {
      errorMessage = "Нет соединения с сервером";
    } else if (errorStr.contains("user not found")) {
      errorMessage = "Пользователь не найден";
    } else if (errorStr.contains("network") || errorStr.contains("timeout")) {
      errorMessage = "Проверьте подключение к интернету";
    } else {
      errorMessage = "Ошибка при входе. Попробуйте еще раз";
    }
    
    AppSnackbars.showError(errorMessage);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLightColor,
      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Warehouse Manager',
                  style: TextStyle(
                    fontSize: 24, 
                    fontWeight: FontWeight.bold, 
                    color: textDarkColor
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Войдите в систему для продолжения',
                  style: TextStyle(color: textGreyColor),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email', 
                    prefixIcon: Icon(Icons.email_outlined)
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите Email';
                    }
                    if (!value.contains('@')) {
                      return 'Введите корректный Email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Пароль', 
                    prefixIcon: Icon(Icons.lock_outline)
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите пароль';
                    }
                    if (value.length < 4) {
                      return 'Пароль должен быть не менее 4 символов';
                    }
                    return null;
                  },
                  onFieldSubmitted: (_) => _isLoading ? null : _login(),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                      ),
                    ),
                    onPressed: _isLoading ? null : _login,
                    child: _isLoading
                        ? const SizedBox(
                            height: 20, 
                            width: 20, 
                            child: CircularProgressIndicator(
                              color: Colors.white, 
                              strokeWidth: 2
                            )
                          )
                        : const Text('Войти'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}