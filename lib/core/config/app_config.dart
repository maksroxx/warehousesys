class AppConfig {
  static const String host = '127.0.0.1';

  static const int defaultPort = 8080;

  static const String apiPrefix = '/api/v1';

  static String get apiBaseUrl {
    final port = _runtimePort ?? defaultPort;
    return 'http://$host:$port$apiPrefix';
  }

  static String get apiUrl {
    final port = _runtimePort ?? defaultPort;
    return 'http://$host:$port';
  }

  static int? _runtimePort;

  static void setPort(int port) {
    _runtimePort = port;
  }
}
