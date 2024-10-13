import 'package:vr_curso_app/app/modules/course/domain/cuorso_dto/cuorso_dto.dart';
import 'package:vr_curso_app/app/modules/course/exception/course_exception.dart';
import 'package:vr_curso_app/app/modules/course/infra/adapters/cuorse_adapter.dart';
import 'package:vr_curso_app/app/modules/course/infra/datasources/i_course_datasourse.dart';

import '../../../../core/shared/services/client_http/i_client_http.dart';

class CourseDatasource implements ICourseDatasource {
  final IClientHttp client;

  CourseDatasource(this.client);

  @override
  Future<dynamic> getAll() async {
    final response = await client.get('your-api-endpoint/courses');

    if (response.statusCode != 200) {
      return CourseException(
        message: 'Failed to fetch courses: ${response.statusCode}',
        stackTrace: StackTrace.current,
      );
    }

    return response.data;
  }

  @override
  Future<dynamic> get(CourseDTO param) async {
    final response = await client.get('your-api-endpoint/courses/${param.entity.id}');

    if (response.statusCode != 200) {
      return CourseException(
        message: 'Failed to fetch course: ${response.statusCode}',
        stackTrace: StackTrace.current,
      );
    }

    return response.data;
  }

  @override
  Future<dynamic> delete(CourseDTO param) async {
    final response = await client.delete('your-api-endpoint/courses/${param.entity.id}');

    if (response.statusCode != 204) {
      return CourseException(
        message: 'Failed to delete course: ${response.statusCode}',
        stackTrace: StackTrace.current,
      );
    }

    return true; // Retorna true se a exclusão foi bem-sucedida
  }

  @override
  Future<dynamic> update(CourseDTO param) async {
    final response = await client.put(
      'your-api-endpoint/courses/${param.entity.id}',
      data: CourseAdapter.toMap(param.entity), // Converte CourseDTO para Map
    );

    if (response.statusCode != 200) {
      return CourseException(
        message: 'Failed to update course: ${response.statusCode}',
        stackTrace: StackTrace.current,
      );
    }

    return response.data;
  }

  @override
  Future<dynamic> create(CourseDTO param) async {
    final response = await client.post(
      'your-api-endpoint/courses',
      data: CourseAdapter.toMap(param.entity), // Converte CourseDTO para Map
    );

    if (response.statusCode != 201) {
      return CourseException(
        message: 'Failed to create course: ${response.statusCode}',
        stackTrace: StackTrace.current,
      );
    }

    return response.data;
  }
}
