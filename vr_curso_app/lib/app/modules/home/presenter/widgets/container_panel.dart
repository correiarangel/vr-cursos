import 'package:flutter/material.dart';

class ContainerPanel extends StatelessWidget {
  final InputContainer inputs;
  const ContainerPanel({
    super.key,
    required this.inputs,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.primaryFixed,
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                blurRadius: 0.5,
                spreadRadius: 0.1,
                offset: const Offset(0.1, 0.1))
          ],
        ),
        height: inputs.height,
        width: inputs.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Text(
              inputs.text,
              style:  TextStyle(color:inputs.color),
              textAlign: TextAlign.center,
            ),
      
          ],
        ),
      ),
    );
  }
}

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
