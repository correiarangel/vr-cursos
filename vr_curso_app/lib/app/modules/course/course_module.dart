
import 'package:flutter_modular/flutter_modular.dart';
import 'package:vr_curso_app/app/modules/course/domain/usecasa/create_course_usecase.dart';
import 'package:vr_curso_app/app/modules/course/domain/usecasa/get_all_course_usecase.dart';
import 'package:vr_curso_app/app/modules/course/domain/usecasa/get_course_usecase.dart';
import 'package:vr_curso_app/app/modules/course/domain/usecasa/update_course_usecase.dart';
import 'package:vr_curso_app/app/modules/course/presenter/blocs/course_bloc.dart';
import 'package:vr_curso_app/app/modules/course/presenter/page/course_page.dart';
import 'package:vr_curso_app/app/modules/course/presenter/page/create_course_page.dart';
import 'package:vr_curso_app/app/modules/course/presenter/page/edit_course_page.dart';
import 'package:vr_curso_app/app/modules/course/presenter/store/course_store.dart';
import 'package:vr_curso_app/app/modules/student/presenter/page/edit_student_page.dart';

import '../../core/core_module.dart';
import '../message_center/message_module.dart';
import 'domain/repositories/i_course_repository.dart';
import 'domain/usecasa/delete_course_usecase.dart';
import 'external/datasources/course_datasource.dart';
import 'infra/datasources/i_course_datasourse.dart';
import 'infra/repositories/course_reposytory.dart';

class CourseModule extends Module {
  @override
  final List<Module> imports = [CoreModule(), MessageModule()];

  @override
  void binds(Injector i) {

    i.add<ICourseDatasource>(CourseDatasource.new);
    i.add<ICourseRepository>(CourseRepository.new);

    i.add<IDeleteCourseUsecase>(DeleteCourseUsecase.new);
    i.add<IGetAllCourseUsecase>(GetAllCourseUsecase.new);
    i.add<ICreateCourseUsecase>(CreateCourseUsecase.new);
    i.add<IGetCourseUsecase>(GetCourseUsecase.new);
    i.add<IUpdateCourseUsecase>(UpdateCourseUsecase.new);
    
    // Registro do bloc e store
    i.addSingleton<CourseBloc>(CourseBloc.new,
        config: BindConfig(
          onDispose: (bloc) => bloc.close(),
        ));
    i.add<CourseStore>(CourseStore.new);
  }

  @override
  void routes(r) {
    // Definição das rotas para o módulo de cursos
    r.child('/course_page',
        child: (context) => CoursePage(
              bloc: Modular.get<CourseBloc>(),
              store: Modular.get<CourseStore>(),
            ));
    r.child('/create_course_page',
        child: (context) => CreateCoursePage(
              bloc: Modular.get<CourseBloc>(),
              store: Modular.get<CourseStore>(),
            ));
    r.child('/edit_course_page',
        child: (context) => EditCoursePage(
              course: r.args.data, // Passe os dados do curso a serem editados
              bloc: Modular.get<CourseBloc>(),
              store: Modular.get<CourseStore>(),
            ));
  }
}
