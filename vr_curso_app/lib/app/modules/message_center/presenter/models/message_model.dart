import '../../domain/entities/message_entity.dart';
import '../../domain/params_dto/massage_params.dart';

class MessageModel extends MessageEntity {
  MessageModel({required super.contentText, required super.type});

  static MessageModel entityToModel(MessageEntity entity) {
    return MessageModel(
      contentText: entity.contentText,
      type: entity.type,
    );
  }

  static MessageEntity modelToentity(MessageModel model) {
    return MessageEntity(
      contentText: model.contentText,
      type: model.type,
    );
  }

  static MessageParamDto modelToDTO(MessageModel model) {
    return MessageParamDto(entity: model);
  }
}
