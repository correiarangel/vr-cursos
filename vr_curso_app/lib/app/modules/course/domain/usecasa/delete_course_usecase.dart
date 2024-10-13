import 'package:vr_curso_app/app/core/types/either.dart';

import '../../exception/course_exception.dart';
import '../cuorso_dto/cuorso_dto.dart';
import '../repositories/i_course_repository.dart';

abstract class IDeleteCourseUsecase {
  Future<Either<ICourseException, bool>> call(CourseDTO param);
}

class DeleteCourseUsecase extends IDeleteCourseUsecase {
  final ICourseRepository _repository;

  DeleteCourseUsecase(this._repository);

  @override
  Future<Either<ICourseException, bool>> call(CourseDTO param) async {

    if (param.entity.id == -1) {
      return left(
        const CourseException(
          message: 'ERROR: Invalid or empty course ID.',
          stackTrace: null,
        ),
      );
    }

    return await _repository.delete(param);
  }
}
