import 'package:flutter/material.dart';

import '../../../../modules/message_center/domain/enums/message_type.dart';
import '../navigation_service/navigation_service.dart';
import 'i_overlay_service.dart';

class AsukaOverlayService extends IOverlayService {
  @override
  void showSnack({
    required Widget contentText,
    required MessageType type,
  }) {
    SnackBar snackBar = CreatSnackBar.creatSnack(
      contentText: contentText,
      type: type,
    );

    ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
        .showSnackBar(snackBar);
  }
}

final class CreatSnackBar {
  static SnackBar creatSnack({
    required Widget contentText,
    required MessageType type,
  }) {
    final colorScheme =
        Theme.of(NavigationService.navigatorKey.currentContext!).colorScheme;
    Color cor = creatColor(type: type, colorScheme: colorScheme);

    return SnackBar(
      dismissDirection: DismissDirection.down,
      backgroundColor: colorScheme.surface.withOpacity(0.6),
      content: contentText,
      showCloseIcon: true,
      closeIconColor: colorScheme.inverseSurface,
      shape: Border.all(
        style: BorderStyle.solid,
        width: 1.5,
        color: cor,
      ),
    );
  }

  static Color creatColor({
    required MessageType type,
    required ColorScheme colorScheme,
  }) {
    if (type == MessageType.success) return colorScheme.primary;
    if (type == MessageType.error) return colorScheme.error;
    if (type == MessageType.warning) return colorScheme.surfaceContainerHighest;
    return colorScheme.primary;
  }
}


