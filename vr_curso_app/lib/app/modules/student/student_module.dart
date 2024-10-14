import 'package:flutter_modular/flutter_modular.dart';
import 'package:vr_curso_app/app/modules/student/domain/i_repository/i_student_repository.dart';
import 'package:vr_curso_app/app/modules/student/domain/usecase/create_student_usecase.dart';
import 'package:vr_curso_app/app/modules/student/domain/usecase/delete_student_usecase.dart';
import 'package:vr_curso_app/app/modules/student/domain/usecase/get_all_student_usecase.dart';
import 'package:vr_curso_app/app/modules/student/domain/usecase/update_student_usecase.dart';
import 'package:vr_curso_app/app/modules/student/external/datasources/student_datasource.dart';
import 'package:vr_curso_app/app/modules/student/infra/repositories/student_reposytory.dart';
import 'package:vr_curso_app/app/modules/student/presenter/blocs/student_bloc.dart';

import 'domain/usecase/get_student_usecase.dart';
import 'infra/datasources/i_student_datasource.dart';
import 'presenter/page/student_page.dart';

class StudentModule extends Module {
  @override
  void binds(Injector i) {
    i.add<IStudentDatasource>(StudentDatasource.new);
    i.add<IStudentRepository>(StudentRepository.new);

    i.add<IDeleteStudentUsecase>(DeleteStudentUsecase.new);
    i.add<IGetAllStudentUsecase>(GetAllStudentUsecase.new);
    i.add<ICreateStudentUsecase>(CreateStudentUsecase.new);
    i.add<IGetStudentUsecase>(GetStudentUsecase.new);
    i.add<IUpdateStudentUsecase>(UpdateStudentUsecase.new);
    i.addSingleton<StudentBloc>(StudentBloc.new,
        config: BindConfig(
          onDispose: (bloc) => bloc.close(),
        ));
  }

  @override
  void routes(r) {
    r.child('/home_page', child: (context) => StudentPage());
    r.module('/', module: StudentModule());
    // r.module('/message_module', module: MessageModule());
  }
}
