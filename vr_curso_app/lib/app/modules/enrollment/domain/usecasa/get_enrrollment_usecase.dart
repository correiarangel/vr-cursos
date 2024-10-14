import 'package:vr_curso_app/app/core/types/either.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/entities/enrollment_entity.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/params_dto/enrollment_dto.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/repositories/i_enrrollment_repository.dart';
import 'package:vr_curso_app/app/modules/enrollment/exception/enrollment_exception.dart';

abstract class IGetEnrollmentUsecase {
  Future<Either<IEnrollmentException, EnrollmentEntity>> call(EnrollmentDTO param);
}


class GetEnrollmentUsecase extends IGetEnrollmentUsecase {
  final IEnrollmentRepository repository;

  GetEnrollmentUsecase(this.repository);

  @override
  Future<Either<IEnrollmentException, EnrollmentEntity>> call(EnrollmentDTO param) async {
    if (param.entity.id == -1) {
      return left(
        const EnrollmentException(
          message: 'Error: enrollment ID cannot be empty or invalid.',
          stackTrace: StackTrace.empty,
        ),
      );
    }

    return await repository.get(param);
  }
}
