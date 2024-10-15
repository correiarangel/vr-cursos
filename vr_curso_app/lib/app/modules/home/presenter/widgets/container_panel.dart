import 'package:flutter/material.dart';
import 'package:vr_curso_app/app/core/shared/widgets/language_icons_carousel.dart';

class ContainerPanel extends StatelessWidget {
  final InputContainer inputs;

  const ContainerPanel({
    super.key,
    required this.inputs,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.primaryFixed,
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                blurRadius: 0.5,
                spreadRadius: 0.1,
                offset: const Offset(0.1, 0.1)),
          ],
        ),
        height: inputs.height,
        width: inputs.width,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FlutterLogo(size: 80.0),
                SizedBox(width: 20.0),
                Icon(Icons.flutter_dash, size: 80),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.android, size: 80),
                SizedBox(width: 20.0),
                Icon(Icons.html, size: 80),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// No changes needed to the InputContainer class
class InputContainer {
  final String text;

  final Color? color;
  final double height;
  final double width;

  InputContainer({
    required this.text,
    this.color,
    required this.height,
    required this.width,
  });
}
