import 'package:vr_curso_app/app/core/value/const_http.dart';
import 'package:vr_curso_app/app/modules/enrollment/exception/enrollment_exception.dart';
import 'package:vr_curso_app/app/modules/enrollment/infra/adapters/enrollment_adapter.dart';

import '../../../../core/shared/services/client_http/i_client_http.dart';
import '../../domain/params_dto/enrollment_dto.dart';
import '../../infra/datasources/i_enrollment_datasourse.dart';

class EnrollmentDatasource implements IEnrollmentDatasource {
  final IClientHttp client;

  EnrollmentDatasource(this.client);

  @override
  Future<dynamic> getAll() async {
    final response = await client.get(ConstHttp.enrollments);

    if (response.statusCode != 200) {
      return EnrollmentException(
        message: 'Failed to fetch enrollments: ${response.statusCode}',
        stackTrace: StackTrace.current,
      );
    }

    return response.data;
  }

  @override
  Future<dynamic> get(EnrollmentDTO param) async {
    final response =
        await client.get('${ConstHttp.enrollments}/${param.entity.id}');

    if (response.statusCode != 200) {
      return EnrollmentException(
        message: 'Failed to fetch enrollment: ${response.statusCode}',
        stackTrace: StackTrace.current,
      );
    }

    return response.data;
  }

  @override
  Future<dynamic> delete(EnrollmentDTO param) async {
    final response =
        await client.delete('${ConstHttp.enrollments}/${param.entity.id}');

    if (response.statusCode != 204) {
      return EnrollmentException(
        message: 'Failed to delete enrollment: ${response.statusCode}',
        stackTrace: StackTrace.current,
      );
    }

    return true;
  }

  @override
  Future<dynamic> update(EnrollmentDTO param) async {
    final response = await client.put(
      ('${ConstHttp.enrollments}/${param.entity.id}'),
      data: EnrollmentAdapter.toMap(param.entity),
    );

    if (response.statusCode != 200) {
      return EnrollmentException(
        message: 'Failed to update enrollment: ${response.statusCode}',
        stackTrace: StackTrace.current,
      );
    }

    return response.data;
  }

  @override
  Future<dynamic> create(EnrollmentDTO param) async {
    final response = await client.post(
     ConstHttp.enrollments,
      data: EnrollmentAdapter.toMap(param.entity),
    );

    if (response.statusCode != 201) {
      return EnrollmentException(
        message: 'Failed to create enrollment: ${response.statusCode}',
        stackTrace: StackTrace.current,
      );
    }

    return response.data;
  }
}
