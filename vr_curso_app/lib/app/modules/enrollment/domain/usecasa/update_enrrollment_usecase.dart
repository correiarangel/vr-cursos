import 'package:vr_curso_app/app/modules/enrollment/domain/entities/enrollment_entity.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/params_dto/enrollment_dto.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/repositories/i_enrrollment_repository.dart';
import 'package:vr_curso_app/app/modules/enrollment/exception/enrollment_exception.dart';

import '../../../../core/types/either.dart';

abstract class IUpdateEnrollmentUsecase {
  Future<Either<IEnrollmentException, EnrollmentEntity>> call(EnrollmentDTO param);
}

class UpdateEnrollmentUsecase extends IUpdateEnrollmentUsecase {
  final IEnrollmentRepository repository;

  UpdateEnrollmentUsecase(this.repository);

  @override
  Future<Either<IEnrollmentException, EnrollmentEntity>> call(EnrollmentDTO param) async {
    if (param.entity.course.description.isEmpty) {
      return left(
        EnrollmentException(
          message: 'ERROR: Course description is empty.',
          stackTrace: StackTrace.current,
        ),
      );
    }
    return await repository.update(param);
  }
}
