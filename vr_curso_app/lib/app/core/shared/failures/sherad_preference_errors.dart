
import 'app_exception_interface.dart';

class SharedPreferencesException extends IAppException {
  SharedPreferencesException({
    required super.message,
    required super.stackTrace,
  });
}
