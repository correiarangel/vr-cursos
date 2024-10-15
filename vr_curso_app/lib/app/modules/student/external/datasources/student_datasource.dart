import 'package:vr_curso_app/app/core/value/const_http.dart';
import 'package:vr_curso_app/app/modules/student/domain/student_dto/student_dto.dart';

import '../../../../core/shared/services/client_http/i_client_http.dart';
import '../../exception/student_exception.dart';
import '../../infra/adapters/student_adapter.dart';
import '../../infra/datasources/i_student_datasource.dart';

class StudentDatasource implements IStudentDatasource {
  final IClientHttp client;

  StudentDatasource(this.client);

  @override
  Future<dynamic> getAll() async {
    
    final response = await client.get(ConstHttp.students);

    if (response.statusCode != 200) {
      return StudentException(
        message: 'Failed to fetch students: ${response.statusCode}',
        stackTrace: StackTrace.current,
      );
    }

    return response.data;
  }

  @override
  Future<dynamic> get(StudentDTO param) async {
    final response = await client.get('${ConstHttp.students}/${param.entity.id}');

    if (response.statusCode != 200) {
      return StudentException(
        message: 'Failed to fetch student: ${response.statusCode}',
        stackTrace: StackTrace.current,
      );
    }

    return response.data;
  }

  @override
  Future<dynamic> delete(StudentDTO param) async {
    final response = await client.delete('${ConstHttp.students}/${param.entity.id}');

    if (response.statusCode != 200) {
      return StudentException(
        message: 'Failed to delete student: ${response.statusCode}',
        stackTrace: StackTrace.current,
      );
    }

    return true; // Return true if the deletion was successful
  }

  @override
  Future<dynamic> update(StudentDTO param) async {
    final response = await client.put(
      '${ConstHttp.students}/${param.entity.id}',
      data: StudentAdapter.toMap(param.entity), // Convert StudentDTO to a Map
    );

    if (response.statusCode != 200) {
      return StudentException(
        message: 'Failed to update student: ${response.statusCode}',
        stackTrace: StackTrace.current,
      );
    }

    return response.data;
  }

  @override
  Future<dynamic> create(StudentDTO param) async {
    final response = await client.post(
      ConstHttp.students,
      data: StudentAdapter.toMap(param.entity), // Convert StudentDTO to a Map
    );

    if (response.statusCode != 200) {
      return StudentException(
        message: 'Failed to create student: ${response.statusCode}',
        stackTrace: StackTrace.current,
      );
    }

    return response.data;
  }
}
