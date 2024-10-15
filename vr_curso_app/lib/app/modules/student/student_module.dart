import 'package:flutter_modular/flutter_modular.dart';
import 'package:vr_curso_app/app/core/core_module.dart';
import 'package:vr_curso_app/app/modules/message_center/message_module.dart';
import 'package:vr_curso_app/app/modules/student/domain/i_repository/i_student_repository.dart';
import 'package:vr_curso_app/app/modules/student/domain/usecase/create_student_usecase.dart';
import 'package:vr_curso_app/app/modules/student/domain/usecase/delete_student_usecase.dart';
import 'package:vr_curso_app/app/modules/student/domain/usecase/get_all_student_usecase.dart';
import 'package:vr_curso_app/app/modules/student/domain/usecase/update_student_usecase.dart';
import 'package:vr_curso_app/app/modules/student/external/datasources/student_datasource.dart';
import 'package:vr_curso_app/app/modules/student/infra/repositories/student_reposytory.dart';
import 'package:vr_curso_app/app/modules/student/presenter/blocs/student_bloc.dart';
import 'package:vr_curso_app/app/modules/student/presenter/page/edit_student_page.dart';
import 'package:vr_curso_app/app/modules/student/presenter/page/student_page.dart';

import 'domain/usecase/get_student_usecase.dart';
import 'infra/datasources/i_student_datasource.dart';
import 'presenter/page/create_student_page.dart';
import 'presenter/store/student_store.dart';

class StudentModule extends Module {
  @override
  final List<Module> imports = [CoreModule(), MessageModule()];
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
    i.add<StudentStore>(StudentStore.new);
  }

  @override
  void routes(r) {
    r.child('/student_page',
        child: (context) => StudentPage(
              bloc: Modular.get<StudentBloc>(),
              store: Modular.get<StudentStore>(),
            ));
    r.child('/create_student_page',
        child: (context) => CreateStudentPage(
              bloc: Modular.get<StudentBloc>(),
              store: Modular.get<StudentStore>(),
            ));
    r.child('/edit_student_page',
        child: (context) => EditStudentPage(
              student: r.args.data,
              bloc: Modular.get<StudentBloc>(),
              store: Modular.get<StudentStore>(),
            ));
  }
}
