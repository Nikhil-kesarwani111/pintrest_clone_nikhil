///Custom Exceptions here

/// Thrown when the API returns a status code (e.g., 404, 500).
class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException({required this.message, this.statusCode});
}

/// Thrown when there is no internet or the request times out.
class NetworkException implements Exception {
  final String message;
  NetworkException({this.message = 'No Internet Connection'});
}

/// Thrown when local storage (caching) fails.
class CacheException implements Exception {
  final String message;
  CacheException({this.message = 'Cache Failure'});
}

/// Thrown specifically for Authentication errors (Clerk).
class AuthException implements Exception {
  final String message;
  AuthException({required this.message});
}