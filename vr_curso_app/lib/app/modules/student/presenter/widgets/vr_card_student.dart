import 'package:flutter/material.dart';

class VrCardStudent extends StatelessWidget {
  final String title;
  final String subTitle;
  const VrCardStudent({super.key, required this.title, required this.subTitle,});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      child: ListTile(
        isThreeLine: true,
        iconColor: colorScheme.primary,
        enabled: true,
        leading: const Icon(
          Icons.local_library_rounded,
          size: 32,
        ),
        title: Text(title),
        subtitle: Text(subTitle),
      ),
    );
  }
}
