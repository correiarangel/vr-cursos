
import 'app_exception_interface.dart';

class AppError extends IAppException {
  const AppError({
    required super.message,
    required super.stackTrace,
  });
}

class PasswordError extends AppError {
  const PasswordError({
    required super.message,
    required super.stackTrace,
  });
}
