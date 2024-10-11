import 'package:flutter_modular/flutter_modular.dart';
import 'package:vr_curso_app/app/modules/home/home_module.dart';


import 'presenter/page/splash_page.dart';

class SplashModule extends Module {
  @override
  void routes(r) {
    r.module('/home_module', module: HomeModule());

    r.child('/', child: (context) => const SplashPage());
  }
}
