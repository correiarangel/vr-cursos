import 'package:vr_curso_app/app/core/types/either.dart';
import 'package:vr_curso_app/app/modules/student/domain/i_repository/i_student_repository.dart';
import 'package:vr_curso_app/app/modules/student/exception/student_exception.dart';



abstract class IDeleteStudentUsecase {
  Future<Either<IStudentException, bool>> call(String id);
}

class DeleteStudentUsecase extends IDeleteStudentUsecase {
  final IStudentRepository _repository;

  DeleteStudentUsecase(this._repository);
  @override
  Future<Either<IStudentException, bool>> call(String id) async {
    if (id.isEmpty) {
      return  left(
        const StudentException(
          message: 'ERRO parametro vazio',
          stackTrace: null,
        ),
      );
    }
    return await _repository.delete(id);
  }
}
