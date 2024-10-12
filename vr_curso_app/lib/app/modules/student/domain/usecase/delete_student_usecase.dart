import 'package:vr_curso_app/app/core/types/either.dart';
import 'package:vr_curso_app/app/modules/student/domain/i_repository/i_student_repository.dart';
import 'package:vr_curso_app/app/modules/student/exception/student_exception.dart';

import '../student_dto/student_dto.dart';



abstract class IDeleteStudentUsecase {
  Future<Either<IStudentException, bool>> call(StudentDTO param);
}

class DeleteStudentUsecase extends IDeleteStudentUsecase {
  final IStudentRepository _repository;

  DeleteStudentUsecase(this._repository);
  @override
  Future<Either<IStudentException, bool>> call(StudentDTO param) async {
    if (param.entity.id==-1) {
      return  left(
        const StudentException(
          message: 'ERRO parametro vazio',
          stackTrace: null,
        ),
      );
    }
    return await _repository.delete(param);
  }
}
