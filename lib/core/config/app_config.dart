class AppConfig {
  AppConfig._();

  /// Base URL for the DARAK.Api backend. Defaults to the deployed Render
  /// service.
  ///
  /// Override at build/run time with `--dart-define=API_BASE_URL=http://10.0.2.2:8080/api`
  /// to point at a local Docker Compose backend instead (see
  /// DARAK-main/docker-compose.yml).
  static String get baseUrl {
    const override = String.fromEnvironment('API_BASE_URL');
    if (override.isNotEmpty) return override;

    return 'https://darak-api-rf9j.onrender.com/api';
  }
}
