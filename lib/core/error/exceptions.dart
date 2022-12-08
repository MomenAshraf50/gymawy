class ServerException implements Exception {
  final String error;
  final String message;
  final int code;

  ServerException({
    required this.error,
    required this.code,
    required this.message,
});
}

class CacheException implements Exception {
  final dynamic error;

  CacheException(this.error);
}