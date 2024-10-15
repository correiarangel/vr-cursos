import 'package:flutter/material.dart';

Future<void> showDialogMaterialDecision({
  Widget? widget,
  required Function() functionYes,
  Function()? functionNot,
  required String message,
  required BuildContext context,
  required String title,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      Color colorText = title.contains('Excluir')
          ? Theme.of(context).colorScheme.onErrorContainer
          : Theme.of(context).colorScheme.primary;
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: colorText,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              functionYes();
            },
            child: Text(
              'SIM',
              style: TextStyle(color: colorText),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              functionNot!=null? functionNot():functionNot;
            },
            child: Text(
              'NÂO',
              style: TextStyle(color: colorText),
            ),
          )
        ],
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      );
    },
  );
}
