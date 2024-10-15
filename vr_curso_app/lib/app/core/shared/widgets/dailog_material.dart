import 'package:flutter/material.dart';

Future<void> showMaterialDialog({
  Function()? function,
  Widget? widget,
  required String message,
  required BuildContext context,
  required String title,
}) {
  
  return showDialog(

    context: context,
    builder: (context) {
      final isError = title.contains('OPS! :(');
      Color colorTitle = isError
          ? Theme.of(context).colorScheme.onError
          : Theme.of(context).colorScheme.primary;
      Color colorMsg = isError
          ? Theme.of(context).colorScheme.onErrorContainer
          : Theme.of(context).colorScheme.onSurface;
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
            color: colorTitle,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (function != null) function();
              if (function == null) Navigator.of(context).pop();
            },
            child: Text(
              'Entendi',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          )
        ],
        content: widget ??
            Text(
              message,
              style: TextStyle(
                fontSize: 16,
                color: colorMsg,
              ),
              textAlign: TextAlign.center,
            ),
      );
    },
  );
}
