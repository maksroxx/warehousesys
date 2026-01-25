import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warehousesys/core/config/app_config.dart';
import 'package:warehousesys/core/theme/app_theme.dart';
import 'package:warehousesys/core/utils/snackbar_utils.dart';
import 'package:warehousesys/features/auth/presentation/auth_provider.dart';
import 'package:warehousesys/features/auth/presentation/login_screen.dart';
import 'package:warehousesys/features/home/presentation/home_screen.dart';
import 'package:warehousesys/l10n/app_localizations.dart';

void main() {
  final port = int.tryParse(Platform.environment['FLOWKEEPER_PORT'] ?? '');
  if (port != null) {
    AppConfig.setPort(port);
  }
  
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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