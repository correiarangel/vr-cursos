import 'package:vr_curso_app/app/core/types/either.dart';

import '../../failures/message_errors.dart';
import '../params_dto/massage_params.dart';
import '../repositories/i_message_repository.dart';

abstract class ISendMessageUsecase {
  Future<Either<MessageError, bool>> call(MessageParamDto param);
}

class SendMessageUsecase extends ISendMessageUsecase {
  final IMessageRepository repository;

  SendMessageUsecase(this.repository);

  @override
  Future<Either<MessageError, bool>> call(MessageParamDto param) async {
    return await repository.showMessage(param);
  }
}
