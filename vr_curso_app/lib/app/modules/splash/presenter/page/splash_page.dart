import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  Future<void> initHome() async {
    //Modular.to.pushReplacementNamed('/home');
    await Future.delayed(const Duration(seconds: 2), () async {
      log('////// VAI PARA LOGIN >)))),)*>');
      Modular.to.pushReplacementNamed('/home_module/home_page');
      //Navigator.pushReplacementNamed(context, '/login_page');
      // Modular.to.pushReplacementNamed('/home_page');
    });
  }

  late Animation<double> animation;

  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);

    animation = Tween<double>(begin: 0.5, end: 80.0).animate(controller)
      ..addListener(() {
        setState(() {});
        if (controller.isCompleted) initHome();
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          
          SizedBox(
            width:animation.value,height: animation.value,
            child: Icon(Icons.school,size:40 ),),
          const SizedBox(width: 8.0),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'VR CURSOS',
                textAlign: TextAlign.start,
                style: TextStyle(
                  // color: ConstColors.colorHighLightDark,
                  fontSize: 42.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
