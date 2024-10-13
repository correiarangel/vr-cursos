import 'package:vr_curso_app/app/core/types/either.dart';
import 'package:vr_curso_app/app/modules/course/domain/entities/cuorse_entity.dart';
import 'package:vr_curso_app/app/modules/course/domain/repositories/i_course_repository.dart';
import 'package:vr_curso_app/app/modules/course/exception/course_exception.dart';

abstract class IGetAllCourseUsecase {
  Future<Either<ICourseException, List<CourseEntity>>> call();
}

class GetAllCourseUsecase extends IGetAllCourseUsecase {
  final ICourseRepository repository;

  GetAllCourseUsecase(this.repository);

  @override
  Future<Either<ICourseException, List<CourseEntity>>> call() async {
    final result = await repository.getAll();
    return result.fold(
      (failure) => left(failure),
      (courses) => right(courses),
    );
  }
}
