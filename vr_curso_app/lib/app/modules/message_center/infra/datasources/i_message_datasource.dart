

import '../../domain/enums/message_type.dart';
import '../../domain/params_dto/massage_params.dart';

abstract class IMessageDatasource {
  Future<dynamic> showMessage({required MessageType type, required MessageParamDto params});
}
