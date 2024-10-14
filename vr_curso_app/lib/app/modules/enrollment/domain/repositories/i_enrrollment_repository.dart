import 'package:vr_curso_app/app/core/types/either.dart';
import 'package:vr_curso_app/app/modules/enrollment/exception/enrollment_exception.dart';

import '../entities/enrollment_entity.dart';
import '../params_dto/enrollment_dto.dart';

abstract class IEnrollmentRepository {
  Future<Either<IEnrollmentException, List<EnrollmentEntity>>> getAll();
  Future<Either<IEnrollmentException, EnrollmentEntity>> create(
      EnrollmentDTO param);
  Future<Either<IEnrollmentException, EnrollmentEntity>> update(
      EnrollmentDTO param);
  Future<Either<IEnrollmentException, EnrollmentEntity>> get(EnrollmentDTO param);
  Future<Either<IEnrollmentException, bool>> delete(EnrollmentDTO param);
}
