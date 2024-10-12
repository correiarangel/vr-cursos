import 'package:vr_curso_app/app/core/types/either.dart';
import 'package:vr_curso_app/app/modules/student/domain/entities/student_entity.dart';

import '../../exception/student_exception.dart';
import '../student_dto/student_dto.dart';

abstract class IStudentRepository {
  Future<Either<IStudentException, List<StudentEntity>>> getAll();
  Future<Either<IStudentException, StudentEntity>> create(StudentDTO param);
  Future<Either<IStudentException, StudentEntity>> update(StudentDTO param);
  Future<Either<IStudentException, StudentEntity>> get(StudentDTO param);
  Future<Either<IStudentException, bool>> delete(StudentDTO param);
}
