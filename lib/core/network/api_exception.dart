class ApiException implements Exception {
  const ApiException({
    required this.message,
    this.traceId,
    this.statusCode,
    this.errors,
    this.sessionExpired = false,
  });

  final String message;
  final String? traceId;
  final int? statusCode;
  final Map<String, List<String>>? errors;

  /// True when this error resulted from a rejected/expired refresh token,
  /// meaning the user has been signed out and must log in again.
  final bool sessionExpired;

  @override
  String toString() => 'ApiException($statusCode): $message';
}
