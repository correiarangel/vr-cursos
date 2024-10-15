import 'package:flutter/material.dart';

class VRInputDecoration {
  static InputDecoration decoration({
    Widget? suffixIcon,
    Widget? icon,
    required BuildContext context,
    required String labelText,
     String? hintText
     
  }) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
            width: 0.8, color: Theme.of(context).colorScheme.primary),
        borderRadius: BorderRadius.circular(8),
      ),
      fillColor: Theme.of(context).colorScheme.primary,
      labelText: labelText,
      hintText: hintText,
      icon: icon,
      labelStyle: TextStyle(
        color: Theme.of(context).colorScheme.primary,
      ),
      hintStyle: TextStyle(
        color: Theme.of(context).colorScheme.primary,
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      contentPadding: const EdgeInsets.only(
        bottom: 10.0,
        top: 20.0,
        right: 20.0,
        left: 10.0,
      ),
      suffixIcon: suffixIcon,
    );
  }
}
