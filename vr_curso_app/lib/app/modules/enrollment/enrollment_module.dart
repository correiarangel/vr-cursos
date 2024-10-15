import 'package:flutter_modular/flutter_modular.dart';
import 'package:vr_curso_app/app/modules/course/course_module.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/usecasa/create_enrrollment_usecase.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/usecasa/delete_enrrollment_usecase.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/usecasa/get_all_enrrollment_usecase.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/usecasa/get_enrrollment_usecase.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/usecasa/update_enrrollment_usecase.dart';
import 'package:vr_curso_app/app/modules/enrollment/external/datasources/enrollment_datasource.dart';
import 'package:vr_curso_app/app/modules/enrollment/infra/datasources/i_enrollment_datasourse.dart';
import 'package:vr_curso_app/app/modules/enrollment/infra/repositories/enrollment_reposytory.dart';
import 'package:vr_curso_app/app/modules/enrollment/presenter/blocs/enrrollment_bloc.dart';
import 'package:vr_curso_app/app/modules/enrollment/presenter/page/create_enrollment.dart';
import 'package:vr_curso_app/app/modules/student/student_module.dart';

import '../../core/core_module.dart';
import '../message_center/message_module.dart';
import 'domain/repositories/i_enrrollment_repository.dart';
import 'presenter/page/enrollment_page.dart';
import 'presenter/store/enrollment_store.dart';

class EnrollmentModule extends Module {
  @override
  final List<Module> imports = [
    CoreModule(),
    MessageModule(),
    StudentModule(),
    CourseModule(),
  ];

  @override
  void binds(Injector i) {
    // Registro das dependências relacionadas a matrículas
    i.add<IEnrollmentDatasource>(EnrollmentDatasource.new);
    i.add<IEnrollmentRepository>(EnrollmentRepository.new);

    i.add<IDeleteEnrollmentUsecase>(DeleteEnrollmentUsecase.new);
    i.add<IGetAllEnrollmentUsecase>(GetAllEnrollmentUsecase.new);
    i.add<ICreateEnrollmentUsecase>(CreateEnrollmentUsecase.new);
    i.add<IGetEnrollmentUsecase>(GetEnrollmentUsecase.new);
    i.add<IUpdateEnrollmentUsecase>(UpdateEnrollmentUsecase.new);

    // Registro do EnrollmentBloc e EnrollmentStore
    i.addSingleton<EnrollmentBloc>(EnrollmentBloc.new,
        config: BindConfig(
          onDispose: (bloc) => bloc.close(),
        ));
    i.add<EnrollmentStore>(EnrollmentStore.new);
  }

  @override
  void routes(r) {
    // Definição das rotas para o módulo de matrículas
    r.child('/enrollment_page',
        child: (context) => EnrollmentPage(
              bloc: Modular.get<EnrollmentBloc>(),
              store: Modular.get<EnrollmentStore>(),
            ));
    r.child('/create_enrollment_page',
        child: (context) => CreateEnrollmentPage(
              bloc: Modular.get<EnrollmentBloc>(),
              store: Modular.get<EnrollmentStore>(),
            ));
/*     r.child('/edit_enrollment_page',
        child: (context) => EditEnrollmentPage(
              enrollment:
                  r.args.data, // Passe os dados da matrícula a serem editados
              bloc: Modular.get<EnrollmentBloc>(),
              store: Modular.get<EnrollmentStore>(),
            )); */
  }
}
