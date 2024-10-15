import 'package:flutter/material.dart';

import '../../../../core/shared/services/navigation_service/navigation_service.dart';
import '../../../../core/shared/services/overlay/asuka_overlay_service.dart';
import '../../../message_center/domain/enums/message_type.dart';
import '../../../message_center/domain/usecases/send_message_usecase.dart';
import '../../../message_center/presenter/models/message_model.dart';


class MessageStore {
  final ISendMessageUsecase usecase;

  MessageStore(this.usecase);

  void creatMessage({
    required String message,
    required ColorScheme color,
    required IconData icon,
    required MessageType type,
  }) {
    setMessage(
      type: type,
      contentText: creatContentSnack(
        color: color,
        message: message,
        icon: icon,
        type: type,
      ),
    );
  }

  void setMessage({
    required Widget contentText,
    required MessageType type,
  }) {
    usecase.call(
      MessageModel.modelToDTO(
        MessageModel(contentText: contentText, type: type),
      ),
    );
  }

  Widget creatContentSnack({
    required MessageType type,
    required ColorScheme color,
    required String message,
    required IconData icon,
  }) {
    Color cor = CreatSnackBar.creatColor(
      type: type,
      colorScheme: color,
    );

    return Row(children: [
      const SizedBox(height: 8),
      SizedBox(
        child: Wrap(
          children: [
            Text(
              message,
              style: TextStyle(color: color.inverseSurface),
            ),
          ],
        ),
      ),
      const Spacer(),
      Icon(icon, color: cor),
      const SizedBox(height: 8)
    ]);
  }

  void setCustomMessage({
    required String message,
    required ColorScheme color,
    required IconData icon,
    required MessageType type,
  }) async {
    if (type == MessageType.error || type == MessageType.warning) {
      creatContentSnack(
        message: message,
        color: color,
        icon: icon,
        type: type,
      );
    }
    if (type == MessageType.success &&
        NavigationService.navigatorKey.currentContext != null) {
      Navigator.of(NavigationService.navigatorKey.currentContext!).pop();
    }
  }
}
