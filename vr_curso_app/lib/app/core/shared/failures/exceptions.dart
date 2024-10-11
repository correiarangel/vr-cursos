import 'app_exception_interface.dart';

class AppException extends IAppException {
  const AppException({
    required super.message,
    required super.stackTrace,
  });
}

class AuthException extends AppException {
  const AuthException({
    required super.message,
    required super.stackTrace,
  });
}

class RepositoryException extends AppException {
  RepositoryException({
    required super.message,
    required super.stackTrace,
  });
}

class FailedUpdateException extends RepositoryException {
  FailedUpdateException({
    required super.message,
    required super.stackTrace,
  });
}
