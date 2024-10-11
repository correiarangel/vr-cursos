import 'dart:developer';

import 'package:flutter/material.dart';

class VRProgress extends StatelessWidget {
  final double height;
  const VRProgress({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    log('------------ Progress -----------------');
    return Column(
      children: [
        SizedBox(height: height),
        const Center(
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}
