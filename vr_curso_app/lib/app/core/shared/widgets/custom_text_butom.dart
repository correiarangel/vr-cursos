import 'package:flutter/material.dart';

class CustomTextButom extends StatelessWidget {
  final String title;
  final Function onPressed;
  final double width;
  const CustomTextButom({
    super.key,
    required this.title,
    required this.onPressed,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextButton(
        onPressed: () => onPressed(),
        style: TextButton.styleFrom(
          // foregroundColor: Colors.black.withOpacity(0.2),
          elevation: 0,
          shadowColor: Colors.transparent,
          side: BorderSide(
            width: 2,
            color: Theme.of(context).primaryColorLight,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          enableFeedback: false,
          visualDensity: VisualDensity.compact,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              wordSpacing: 20,
            ),
          ),
        ),
      ),
    );
  }
}
