import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:vr_curso_app/app/app_module.dart';
import 'package:vr_curso_app/app/app_widget.dart';


void main() {
  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}