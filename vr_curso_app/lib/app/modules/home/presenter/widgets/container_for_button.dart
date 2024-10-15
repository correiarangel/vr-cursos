import 'package:flutter/material.dart';

class ContainerForButton extends StatelessWidget {
  final InputContainer inputs;
  const ContainerForButton({
    super.key,
    required this.inputs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
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
          Icon(
            inputs.icon,
            size: 32,
            color: inputs.color,
          ),
          const SizedBox(height: 2),
          Text(
            inputs.text,
            style:  TextStyle(color:inputs.color),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class InputContainer {
  final String text;
  final IconData icon;
  final Color? color;
  final double height;
  final double width;
 

  InputContainer({
    required this.text,
    required this.icon,
    this.color,
    required this.height,
    required this.width,

  });
}
