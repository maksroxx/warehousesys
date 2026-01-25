// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warehousesys/core/config/app_config.dart';
import 'package:warehousesys/core/services/server_manager.dart';
import 'package:warehousesys/core/theme/app_theme.dart';
import 'package:warehousesys/core/utils/snackbar_utils.dart';
import 'package:warehousesys/features/auth/presentation/auth_provider.dart';
import 'package:warehousesys/features/auth/presentation/login_screen.dart';
import 'package:warehousesys/features/home/presentation/home_screen.dart';
import 'package:warehousesys/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    print("🚀 Flutter: Инициализация сервера...");
    final int port = await ServerManager.start();
    print("✅ Flutter: Сервер успешно запущен на порту $port");

    AppConfig.setPort(port);

    runApp(const ProviderScope(child: MyApp()));

  } catch (e, stack) {
    print("❌ Flutter: Критическая ошибка запуска: $e");
    print(stack);

    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 64),
                const SizedBox(height: 24),
                const Text(
                  "Ошибка запуска системы",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Text(
                    e.toString(),
                    style: const TextStyle(fontFamily: 'Courier', color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      print("🛑 Flutter: Приложение закрывается, останавливаем сервер...");
      ServerManager.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return MaterialApp(
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      
      title: 'Warehouse Manager',
      debugShowCheckedModeBanner: false,
      
      theme: buildAppTheme(),
      
      locale: const Locale('ru'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      
      home: authState.isLoading
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : authState.isAuthenticated
              ? const HomeScreen()
              : const LoginScreen(),
    );
  }
}