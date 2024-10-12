

import 'package:vr_curso_app/app/modules/student/domain/entities/student_entity.dart';
import 'package:vr_curso_app/app/modules/student/domain/i_repository/i_student_repository.dart';
import 'package:vr_curso_app/app/modules/student/domain/student_dto/student_dto.dart';
import 'package:vr_curso_app/app/modules/student/exception/student_exception.dart';

import '../../../../core/types/either.dart';

abstract class ICreateStudentUsecase {
  Future<Either<IStudentException, StudentEntity>> call(StudentDTO param);
}

class CreateStudentUsecase extends ICreateStudentUsecase {
  final IStudentRepository _repository;

  CreateStudentUsecase(this._repository);
  @override
  Future<Either<IStudentException, StudentEntity>> call(StudentDTO param) async {
    if (param.entity.name.isEmpty) {
      return left(
        const StudentException(
          message: 'ERROR: name esta vazio',
          stackTrace: StackTrace.empty,
        ),
      );
    }
    return await _repository.create(param: param);
  }
}
