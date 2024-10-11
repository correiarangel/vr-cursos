
import '../../../core/shared/failures/app_exception_interface.dart';

class MessageError extends IAppException {
  const MessageError({
    required super.message,
    required super.stackTrace,
  });
}
