import 'package:flutter_modular/flutter_modular.dart';
import 'package:vr_curso_app/app/modules/course/course_module.dart';
import 'package:vr_curso_app/app/modules/splash/splash_module.dart';

import 'modules/student/student_module.dart';

class AppModule extends Module {
  @override
  void routes(r) {
    r.module('/', module: SplashModule());

  }
}
