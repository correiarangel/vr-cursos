// Interface do caso de uso para criar uma matrícula (Enrollment)
import 'package:vr_curso_app/app/modules/enrollment/domain/params_dto/enrollment_dto.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/valeu_object/enrrollment_object.dart';
import 'package:vr_curso_app/app/modules/enrollment/exception/enrollment_exception.dart';

import '../../../../core/types/either.dart';
import '../entities/enrollment_entity.dart';
import '../repositories/i_enrrollment_repository.dart';

abstract class ICreateEnrollmentUsecase {
  Future<Either<IEnrollmentException, EnrollmentEntity>> call({
    required EnrollmentDTO param,
  });
}

class CreateEnrollmentUsecase extends ICreateEnrollmentUsecase {
  final IEnrollmentRepository repository;

  CreateEnrollmentUsecase(this.repository);

  @override
  Future<Either<IEnrollmentException, EnrollmentEntity>> call({
    required EnrollmentDTO param,
  }) async {
    if (!EnrollmentObject.valid(param)) {
      return left(
        EnrollmentException(
          message: 'ERROR: Student or Course is missing.',
          stackTrace: StackTrace.current,
        ),
      );
    }
    return await repository.create(param);
  }
}
