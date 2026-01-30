///Domain Failures here

/// Base Failure class that all specific failures inherit from.
abstract class Failure {
  final String message;
  const Failure(this.message);
}

/// Used when the server returns an error (mapped from ServerException).
class ServerFailure extends Failure {
  const ServerFailure({required String message}) : super(message);
}

/// Used when internet is down (mapped from NetworkException).
class NetworkFailure extends Failure {
  const NetworkFailure({String message = 'Please check your internet connection'})
      : super(message);
}

/// Used when loading locally saved data fails.
class CacheFailure extends Failure {
  const CacheFailure({String message = 'Cache Failure'}) : super(message);
}

/// Used when login/signup fails  ("Invalid password").
class AuthFailure extends Failure {
  const AuthFailure({required String message}) : super(message);
}