
import 'package:flutter_modular/flutter_modular.dart';
import 'package:vr_curso_app/app/modules/splash/splash_module.dart';

import 'modules/student/student_module.dart';

class AppModule extends Module {
  @override
  void routes(r) {
    r.module('/', module: SplashModule());
        r.module('/student_module', module: StudentModule());
   // r.module('/message_module', module: MessageModule());
  }
}