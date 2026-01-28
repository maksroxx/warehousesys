// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class ServerManager {
  static Process? _process;

  static Future<int> start() async {
    final String executablePath = await _getExecutablePath();
    final String dataDir = await _getDataDir();

    print("🚀 Flutter: Подготовка к запуску сервера...");
    print("    Bin: $executablePath");
    print("    Data: $dataDir");

    final dbFolder = p.join(dataDir, 'data');
    if (!await Directory(dbFolder).exists()) {
      print("    Создание папки базы данных: $dbFolder");
      await Directory(dbFolder).create(recursive: true);
    }

    await _prepareConfigs(executablePath, dataDir);

    if (!File(executablePath).existsSync()) {
      throw Exception("Бинарный файл сервера не найден по пути: $executablePath");
    }

    final configPath = p.join(dataDir, 'config', 'config.yaml');

    _process = await Process.start(
      executablePath,
      ['--config', configPath], 
      workingDirectory: dataDir, 
      runInShell: false,
    );

    _process!.stderr.transform(utf8.decoder).listen((data) {
      print('[GO ERR]: ${data.trim()}');
    });

    return await _waitForPort(_process!.stdout);
  }

  static Future<void> _prepareConfigs(String exePath, String dataDir) async {
    final bundleResourcesDir = p.join(p.dirname(exePath), '..', 'Resources', 'templates');
    final userConfigDir = p.join(dataDir, 'config');
    
    if (!await Directory(userConfigDir).exists()) {
      await Directory(userConfigDir).create(recursive: true);
    }

    final stockSource = p.join(bundleResourcesDir, 'stock_config.yml');
    final stockTarget = p.join(userConfigDir, 'stock_config.yml');
    
    if (!await File(stockTarget).exists()) {
      if (await File(stockSource).exists()) {
        await File(stockSource).copy(stockTarget);
      }
    }

    final configSource = p.join(bundleResourcesDir, 'config.yaml');
    final configTarget = p.join(userConfigDir, 'config.yaml');

    if (await File(configSource).exists()) {
      if (!await File(configTarget).exists()) {
        print("    [Config] Создание нового config.yaml...");
        var content = await File(configSource).readAsString();        
        content = content.replaceAll(RegExp(r'dsn: ".*"'), 'dsn: "./data/local.db"');
        content = content.replaceAll(RegExp(r'driver: ".*"'), 'driver: "sqlite"');
        
        content = content.replaceAll(RegExp(r'port: \s*\d+'), 'port: 0');
        
        await File(configTarget).writeAsString(content);
      } 
      else {
        print("    [Config] Обновление порта в существующем config.yaml...");
        var currentContent = await File(configTarget).readAsString();
        
        final newContent = currentContent.replaceAll(RegExp(r'port: \s*\d+'), 'port: 0');        
        if (currentContent != newContent) {
          await File(configTarget).writeAsString(newContent);
        }
      }
    } else {
      print("⚠️ Шаблон config.yaml не найден по пути: $configSource");
    }
  }

  static Future<int> _waitForPort(Stream<List<int>> stdout) async {
    final broadcastStream = stdout.asBroadcastStream();
    
    broadcastStream.transform(utf8.decoder).listen((data) {
      print('[GO]: ${data.trim()}');
    });

    await for (final line in broadcastStream.transform(utf8.decoder).transform(const LineSplitter())) {
      if (line.contains("FLOWKEEPER_STARTED_PORT:")) {
        final parts = line.split(":");
        if (parts.length == 2) {
          final port = int.tryParse(parts[1].trim());
          if (port != null) return port;
        }
      }
    }
    throw Exception("Сервер завершил работу, не сообщив порт. Проверьте [GO ERR] выше.");
  }

  static Future<String> _getExecutablePath() async {
    if (kDebugMode) {
      return '/Users/maksroxx/Documents/Projects/FlowKeeper/bin/server_binary';
    }

    final dir = p.dirname(Platform.resolvedExecutable);
    
    if (Platform.isMacOS) {
      return p.join(dir, 'server_binary');
    } else if (Platform.isWindows) {
      return p.join(dir, 'server.exe');
    }
    
    throw Exception("Unsupported platform");
  }

  static Future<String> _getDataDir() async {
    final dir = await getApplicationSupportDirectory();
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return dir.path;
  }

  static void stop() {
    _process?.kill();
    print("🛑 Flutter: Сервер остановлен");
  }
}