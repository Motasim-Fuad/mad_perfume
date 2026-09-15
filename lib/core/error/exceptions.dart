class ServerException implements Exception {
  ServerException([this.message = 'Server error']);

  final String message;
}

class CacheException implements Exception {
  CacheException([this.message = 'Cache error']);

  final String message;
}

class AuthException implements Exception {
  AuthException([this.message = 'Authentication failed']);

  final String message;
}

class ValidationException implements Exception {
  ValidationException([this.message = 'Invalid input']);

  final String message;
}
