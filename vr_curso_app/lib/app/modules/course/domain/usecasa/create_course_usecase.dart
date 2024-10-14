import 'package:vr_curso_app/app/core/types/either.dart';
import 'package:vr_curso_app/app/modules/course/domain/cuorso_dto/cuorso_dto.dart';
import 'package:vr_curso_app/app/modules/course/domain/repositories/i_course_repository.dart';

import '../../exception/course_exception.dart';
import '../entities/cuorse_entity.dart';

abstract class ICreateCourseUsecase {
  Future<Either<ICourseException, CourseEntity>> call(CourseDTO param);
}

class CreateCourseUsecase extends ICreateCourseUsecase {
  final ICourseRepository repository;

  CreateCourseUsecase(this.repository);

  @override
  Future<Either<ICourseException, CourseEntity>> call(CourseDTO param) async {

    if (param.entity.description.isEmpty) {
      return left(
        const CourseException(
          message: 'ERROR: Course description is empty.',
          stackTrace: StackTrace.empty,
        ),
      );
    }

    return await repository.create(param);
  }
}
