
import 'package:vr_curso_app/app/core/types/either.dart';

import '../../failures/message_errors.dart';
import '../params_dto/massage_params.dart';


abstract class IMessageRepository {
  Future<Either<MessageError, bool>> showMessage(MessageParamDto param);
}
