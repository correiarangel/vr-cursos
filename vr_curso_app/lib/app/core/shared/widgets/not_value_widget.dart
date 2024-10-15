import 'package:flutter/material.dart';

class NotValueWidget extends StatelessWidget {
  final List<dynamic> list;
  final void Function()? onPressed;
  const NotValueWidget({
    super.key,
    required this.list,
    required this.onPressed,

  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width / 100;
    final height = MediaQuery.of(context).size.height / 100;
    return Visibility(
      visible: list.isEmpty,
      child: SizedBox(
        width: width * 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height * 25),
            const Text("OPS! ", style: TextStyle(fontSize: 32)),
            const SizedBox(height: 16),
            const Text(
              "Não há dados a exibir !...",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: onPressed,
              icon: const Icon(
                Icons.restart_alt,
                size: 32,
              ),
              label: const Text(
                'Recarregar',
                style: TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
