import 'package:vr_curso_app/app/core/types/either.dart';
import 'package:vr_curso_app/app/modules/course/domain/cuorso_dto/cuorso_dto.dart';
import 'package:vr_curso_app/app/modules/course/domain/entities/cuorse_entity.dart';
import 'package:vr_curso_app/app/modules/course/exception/course_exception.dart';

abstract class ICourseRepository {
  Future<Either<ICourseException, List<CourseEntity>>> getAll();
  Future<Either<ICourseException, CourseEntity>> create(CourseDTO param);
  Future<Either<ICourseException, CourseEntity>> update(CourseDTO param);
  Future<Either<ICourseException, CourseEntity>> get(CourseDTO param);
  Future<Either<ICourseException, bool>> delete(CourseDTO param);
}
