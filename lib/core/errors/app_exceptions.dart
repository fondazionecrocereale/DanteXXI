abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic details;

  const AppException(this.message, {this.code, this.details});

  @override
  String toString() =>
      'AppException: $message${code != null ? ' (Code: $code)' : ''}';
}

class NetworkException extends AppException {
  const NetworkException(super.message, {super.code, super.details});

  @override
  String toString() =>
      'NetworkException: $message${code != null ? ' (Code: $code)' : ''}';
}

class AuthenticationException extends AppException {
  const AuthenticationException(super.message, {super.code, super.details});

  @override
  String toString() =>
      'AuthenticationException: $message${code != null ? ' (Code: $code)' : ''}';
}

class ValidationException extends AppException {
  const ValidationException(super.message, {super.code, super.details});

  @override
  String toString() =>
      'ValidationException: $message${code != null ? ' (Code: $code)' : ''}';
}

class CacheException extends AppException {
  const CacheException(super.message, {super.code, super.details});

  @override
  String toString() =>
      'CacheException: $message${code != null ? ' (Code: $code)' : ''}';
}

class DatabaseException extends AppException {
  const DatabaseException(super.message, {super.code, super.details});

  @override
  String toString() =>
      'DatabaseException: $message${code != null ? ' (Code: $code)' : ''}';
}

class FileException extends AppException {
  const FileException(super.message, {super.code, super.details});

  @override
  String toString() =>
      'FileException: $message${code != null ? ' (Code: $code)' : ''}';
}

class AudioException extends AppException {
  const AudioException(super.message, {super.code, super.details});

  @override
  String toString() =>
      'AudioException: $message${code != null ? ' (Code: $code)' : ''}';
}

class VideoException extends AppException {
  const VideoException(super.message, {super.code, super.details});

  @override
  String toString() =>
      'VideoException: $message${code != null ? ' (Code: $code)' : ''}';
}

class UnknownException extends AppException {
  const UnknownException(super.message, {super.code, super.details});

  @override
  String toString() =>
      'UnknownException: $message${code != null ? ' (Code: $code)' : ''}';
}
