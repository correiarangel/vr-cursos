import 'package:vr_curso_app/app/modules/course/domain/cuorso_dto/cuorso_dto.dart';

abstract class ICourseDatasource {
  Future<dynamic> getAll();
  Future<dynamic> get(CourseDTO param);
  Future<dynamic> delete(CourseDTO param);
  Future<dynamic> update(CourseDTO param);
  Future<dynamic> create(CourseDTO param);
}
