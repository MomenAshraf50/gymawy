class ServerException implements Exception {
  final String message;
//  final int? code;

  ServerException({
  //   this.code,
    required this.message,
});
}

class CacheException implements Exception {
  final dynamic error;

  CacheException(this.error);
}