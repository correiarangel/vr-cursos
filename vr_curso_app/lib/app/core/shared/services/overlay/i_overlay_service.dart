import 'package:flutter/material.dart';

import '../../../../modules/message_center/domain/enums/message_type.dart';

abstract class IOverlayService {
  void showSnack({
    required Widget contentText,
    required MessageType type,
  });
}
