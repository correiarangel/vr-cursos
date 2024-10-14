import 'package:vr_curso_app/app/core/types/either.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/entities/enrollment_entity.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/repositories/i_enrrollment_repository.dart';
import 'package:vr_curso_app/app/modules/enrollment/exception/enrollment_exception.dart';

abstract class IGetAllEnrollmentUsecase {
  Future<Either<IEnrollmentException, List<EnrollmentEntity>>> call();
}

class GetAllEnrollmentUsecase extends IGetAllEnrollmentUsecase {
  final IEnrollmentRepository repository;

  GetAllEnrollmentUsecase(this.repository);

  @override
  Future<Either<IEnrollmentException, List<EnrollmentEntity>>> call() async {
    final result = await repository.getAll();
    return result.fold(
      (failure) => left(failure),  
      (enrollments) => right(enrollments),  
    );
  }
}
