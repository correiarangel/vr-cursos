import 'app_exception_interface.dart';

class AppException extends IAppException {
  const AppException({
    required super.message,
    required super.stackTrace,
  });
}

class ClientHttpException extends AppException {
  const ClientHttpException({
    required super.message,
    required super.stackTrace,
  });


}
