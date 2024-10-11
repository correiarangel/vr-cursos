import 'package:flutter/material.dart';

import '../enums/message_type.dart';

class MessageEntity {
  final Widget contentText;
  final MessageType type;

  MessageEntity({required this.contentText, required this.type});
}


