
import '../../../core/shared/services/overlay/i_overlay_service.dart';
import '../domain/enums/message_type.dart';
import '../domain/params_dto/massage_params.dart';
import '../infra/datasources/i_message_datasource.dart';

class MessageDatasource implements IMessageDatasource {
  final IOverlayService service;

  MessageDatasource(this.service);

  @override
  Future<dynamic> showMessage({
    required MessageType type,
    required MessageParamDto params,
  }) async {
    return service.showSnack(
      type: params.entity.type,
      contentText: params.entity.contentText,
    );
  }
}
