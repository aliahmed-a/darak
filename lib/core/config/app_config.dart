import 'dart:io';

class AppConfig {
  AppConfig._();

  static const int _devPort = 8080;

  /// Base URL for the DARAK.Api backend. Defaults to the Docker Compose
  /// deployment (see DARAK-main/docker-compose.yml), which publishes the
  /// API on port 8080.
  ///
  /// Override at build/run time with `--dart-define=API_BASE_URL=https://your-host/api`.
  static String get baseUrl {
    const override = String.fromEnvironment('API_BASE_URL');
    if (override.isNotEmpty) return override;

    // The Android emulator can't reach the host machine via `localhost`.
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:$_devPort/api';
    }
    return 'http://localhost:$_devPort/api';
  }
}
