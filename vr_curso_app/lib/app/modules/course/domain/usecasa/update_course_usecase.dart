import 'package:vr_curso_app/app/modules/course/domain/cuorso_dto/cuorso_dto.dart';
import 'package:vr_curso_app/app/modules/course/domain/entities/cuorse_entity.dart';
import 'package:vr_curso_app/app/modules/course/domain/repositories/i_course_repository.dart';
import 'package:vr_curso_app/app/modules/course/exception/course_exception.dart';

import '../../../../core/types/either.dart';

abstract class IUpdateCourseUsecase {
  Future<Either<ICourseException, CourseEntity>> call(CourseDTO param);
}

class UpdateCourseUsecase extends IUpdateCourseUsecase {
  final ICourseRepository _repository;

  UpdateCourseUsecase(this._repository);

  @override
  Future<Either<ICourseException, CourseEntity>> call(CourseDTO param) async {
    if (param.entity.description.isEmpty) {
      return left(
        CourseException(
          message: 'ERROR: Course description is empty.',
          stackTrace: StackTrace.current,
        ),
      );
    }

    return await _repository.update(param);
  }
}
