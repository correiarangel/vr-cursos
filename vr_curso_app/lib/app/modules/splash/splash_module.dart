import 'package:flutter_modular/flutter_modular.dart';
import 'package:vr_curso_app/app/modules/home/home_module.dart';


import '../course/course_module.dart';
import '../enrollment/enrollment_module.dart';
import '../student/student_module.dart';
import 'presenter/page/splash_page.dart';

class SplashModule extends Module {
  @override
  void routes(r) {
    r.module('/home_module', module: HomeModule());
    r.module('/enrollment_module', module: EnrollmentModule());
    r.module('/student_module', module: StudentModule());
    r.module('/course_module', module: CourseModule());
    r.child('/', child: (context) => const SplashPage());
  }
}
