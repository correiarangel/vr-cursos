import 'package:flutter_modular/flutter_modular.dart';
import 'package:vr_curso_app/app/modules/home/presenter/page/home_page.dart';

class HomeModule extends Module {

  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child('/home_page', child: (context) => const HomePage());
  }
}
