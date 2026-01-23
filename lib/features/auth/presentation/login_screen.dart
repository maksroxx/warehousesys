// ignore_for_file: deprecated_member_use

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

  Future<void> _login() async {
    setState(() => _isLoading = true);
    FocusScope.of(context).unfocus();

    try {
      await ref.read(authProvider.notifier).login(
            _emailController.text.trim(),
            _passwordController.text,
          );
      
      if (mounted) {
        AppSnackbars.showSuccess(context, 'Добро пожаловать в Warehouse Manager!');
      }
    } catch (e) {
      if (mounted) {
        String errorMessage = "Произошла ошибка при входе";
        final errorStr = e.toString().toLowerCase();

        if (errorStr.contains("401") || errorStr.contains("unauthorized")) {
          errorMessage = "Неверный Email или пароль. Попробуйте снова.";
        } else if (errorStr.contains("connection") || errorStr.contains("socket")) {
          errorMessage = "Нет соединения с сервером. Проверьте интернет.";
        } else if (errorStr.contains("user not found")) {
          errorMessage = "Пользователь с таким email не найден.";
        }
        AppSnackbars.showError(context, errorMessage);
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Warehouse Manager',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textDarkColor),
              ),
              const SizedBox(height: 8),
              const Text(
                'Войдите в систему для продолжения',
                style: TextStyle(color: textGreyColor),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email_outlined)),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Пароль', prefixIcon: Icon(Icons.lock_outline)),
                onSubmitted: (_) => _login(),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: _isLoading ? null : _login,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20, 
                          width: 20, 
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                        )
                      : const Text('Войти'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}