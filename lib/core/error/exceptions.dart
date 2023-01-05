class ServerException implements Exception {
  final String message;
  final int code;

  ServerException({
    required this.code,
    required this.message,
});
}

class CacheException implements Exception {
  final dynamic error;

  CacheException(this.error);
}