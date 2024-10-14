import 'package:vr_curso_app/app/core/types/either.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/params_dto/enrollment_dto.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/repositories/i_enrrollment_repository.dart';
import 'package:vr_curso_app/app/modules/enrollment/exception/enrollment_exception.dart';

abstract class IDeleteEnrollmentUsecase {
  Future<Either<IEnrollmentException, bool>> call(EnrollmentDTO param);
}

class DeleteEnrollmentUsecase extends IDeleteEnrollmentUsecase {
  final IEnrollmentRepository repository;

  DeleteEnrollmentUsecase(this.repository);

  @override
  Future<Either<IEnrollmentException, bool>> call(EnrollmentDTO param) async {
    if (param.entity.id == -1) {
      return left(
        EnrollmentException(
          message: 'ERROR: Invalid or empty enrollment ID.',
          stackTrace: StackTrace.current,
        ),
      );
    }

    return await repository.delete(param);
  }
}
