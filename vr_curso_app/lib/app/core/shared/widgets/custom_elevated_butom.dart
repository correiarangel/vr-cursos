import 'package:flutter/material.dart';

class CustomElevatedButom extends StatelessWidget {
  final String title;
  final Function onPressed;
  final double width;
  const CustomElevatedButom({
    super.key,
    required this.width,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 48,
      child: ElevatedButton(
        onPressed: () => onPressed(),
        style: ElevatedButton.styleFrom(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            wordSpacing: 20,
          ),
        ),
      ),
    );
  }
}
