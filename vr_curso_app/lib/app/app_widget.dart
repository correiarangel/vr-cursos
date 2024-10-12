
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:vr_curso_app/app/core/shared/services/navigation_service/navigation_service.dart';


class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Modular.setNavigatorKey(NavigationService.navigatorKey);

    return MaterialApp.router(
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      title: 'VR Curso',

      themeMode: ThemeMode.light,
      darkTheme: ThemeData.light(),
      theme: ThemeData(primarySwatch: Colors.orange),
    );
  }
}
