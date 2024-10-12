import 'package:vr_curso_app/app/core/types/either.dart';
import 'package:vr_curso_app/app/modules/student/domain/entities/student_entity.dart';
import 'package:vr_curso_app/app/modules/student/domain/student_dto/student_dto.dart';
import 'package:vr_curso_app/app/modules/student/exception/student_exception.dart';

import '../i_repository/i_student_repository.dart';

abstract class IUpdateStudentUsecase {
  Future<Either<IStudentException, StudentEntity>> call(
    StudentDTO param,
  );
}

class UpdateStudentUsecase extends IUpdateStudentUsecase {
  final IStudentRepository _repository;

  UpdateStudentUsecase(this._repository);
  @override
  Future<Either<IStudentException, StudentEntity>> call(
      StudentDTO param) async {
    if (param.entity.name.isEmpty) {
      return left(
        StudentException(
          message: 'ERROR: name esta vazio',
          stackTrace: StackTrace.current,
        ),
      );
    }
    return await _repository.update(
      param,
    );
  }
}
