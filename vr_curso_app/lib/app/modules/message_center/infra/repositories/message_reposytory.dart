


import 'package:vr_curso_app/app/modules/message_center/failures/message_errors.dart';

import '../../../../core/types/either.dart';
import '../../domain/params_dto/massage_params.dart';
import '../../domain/repositories/i_message_repository.dart';
import '../datasources/i_message_datasource.dart';

class MessageRepository implements IMessageRepository {
  final IMessageDatasource datasource;

  MessageRepository({
    required this.datasource,
  });

  @override
  Future<Either<MessageError, bool>> showMessage(MessageParamDto param) async {
    dynamic resultError;
    try {
      datasource.showMessage(params: param,type: param.entity.type );

      return right(true);
    } on MessageError catch (err, s) {
      resultError = MessageError(message: err.message, stackTrace: s);
    } on Expando catch (err, s) {
      resultError =
          MessageError(message: 'OPS! erro ao geral menssage', stackTrace: s);
    }
    return left(resultError);
  }
}
