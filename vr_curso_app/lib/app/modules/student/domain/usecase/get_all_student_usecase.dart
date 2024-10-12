import 'package:vr_curso_app/app/core/types/either.dart';
import 'package:vr_curso_app/app/modules/student/domain/entities/student_entity.dart';
import 'package:vr_curso_app/app/modules/student/domain/i_repository/i_student_repository.dart';
import 'package:vr_curso_app/app/modules/student/exception/student_exception.dart';

abstract class IGetAllStudentUsecase {
  Future<Either<IStudentException, List<StudentEntity>>> call();
}

class GetAllStudentUsecase extends IGetAllStudentUsecase {
  final IStudentRepository _repository;

  GetAllStudentUsecase(this._repository);
  @override
  Future<Either<IStudentException, List<StudentEntity>>> call() async {
    final result = await _repository.getAll();
    return result.fold(
      (failure) => left(failure),
      (students) => right(students),
    );
  }
}
