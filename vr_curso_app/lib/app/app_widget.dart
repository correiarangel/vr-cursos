import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:vr_curso_app/app/core/shared/services/navigation_service/navigation_service.dart';
import 'package:vr_curso_app/app/ui/bloc/thrme_cubit.dart';
import 'package:vr_curso_app/app/ui/theme/material_theme_vr.dart';
import 'package:vr_curso_app/app/ui/theme/util.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Modular.setNavigatorKey(NavigationService.navigatorKey);
    TextTheme textTheme = createTextTheme(context, "Roboto", "Roboto Serif");
    final theme = MaterialThemeVr(textTheme);
    return BlocProvider<ThemeCubit>(
      create: (context) => ThemeCubit(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate,
        title: 'VR Curso',
        themeMode: ThemeMode.light,
        darkTheme: ThemeData.light(),
        theme: theme.light(),
      ),
    );
  }
}
