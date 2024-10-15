import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:vr_curso_app/app/core/shared/widgets/vr_progress.dart';

import '../../../../core/shared/widgets/loading_animation.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  Future<void> initHome() async {
    await Future.delayed(const Duration(seconds: 3), () async {
      Modular.to.pushReplacementNamed('/home_module/home_page');
    });
  }

  @override
  void initState() {
    initHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final height = (size.height / 100);
    final width = (size.width / 100);
    return Scaffold(
      body: SizedBox(
        width: width * 100,
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'VR CURSOS',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox( width: width * 10),
            const LoadingAnimation()
          ],
        ),
      ),
    );
  }
}
