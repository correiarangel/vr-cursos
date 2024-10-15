import 'package:flutter/material.dart';

class LoadingAnimation extends StatefulWidget {
  const LoadingAnimation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoadingAnimationState createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
      reverseDuration: const Duration(seconds: 2)
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.0, end: 130.0).animate(_controller);
  
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final coor = Theme.of(context).colorScheme;
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          1,
          (index) => ScaleTransition(
            scale: _animation,
            child: Container(
              padding: EdgeInsets.all(48),
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: coor.primaryFixed),
            ),
          ),
        ),
      ),
    );
  }
}
