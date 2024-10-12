import 'package:vr_curso_app/app/core/types/either.dart';
import 'package:vr_curso_app/app/modules/student/domain/entities/student_entity.dart';
import 'package:vr_curso_app/app/modules/student/domain/student_dto/student_dto.dart';
import 'package:vr_curso_app/app/modules/student/exception/student_exception.dart';

import '../i_repository/i_student_repository.dart';

abstract class IGetStudentUsecase {
  Future<Either<IStudentException, StudentEntity>> call(StudentDTO param);
}

class GetStudentUsecase extends IGetStudentUsecase {
  final IStudentRepository _repository;

  GetStudentUsecase(this._repository);
  @override
  Future<Either<IStudentException, StudentEntity>> call(StudentDTO param) async {
    if (param.entity.id==-1) {
      return left(
        const StudentException(
          message: 'ERRO parametro - id não pode ser vazio. ',
          stackTrace: StackTrace.empty,
        ),
      );
    }

    return await _repository.get(param);
  }
}
