import 'package:vr_curso_app/app/core/types/either.dart';
import 'package:vr_curso_app/app/modules/course/domain/cuorso_dto/cuorso_dto.dart';
import 'package:vr_curso_app/app/modules/course/domain/entities/cuorse_entity.dart';
import 'package:vr_curso_app/app/modules/course/domain/repositories/i_course_repository.dart';
import 'package:vr_curso_app/app/modules/course/exception/course_exception.dart';

abstract class IGetCourseUsecase {
  Future<Either<ICourseException, CourseEntity>> call(CourseDTO param);
}

class GetCourseUsecase extends IGetCourseUsecase {
  final ICourseRepository _repository;

  GetCourseUsecase(this._repository);

  @override
  Future<Either<ICourseException, CourseEntity>> call(CourseDTO param) async {
    if (param.entity.id == -1) {
      return left(
        const CourseException(
          message: 'Error: course ID cannot be empty or invalid.',
          stackTrace: StackTrace.empty,
        ),
      );
    }

    return await _repository.get(param);
  }
}
