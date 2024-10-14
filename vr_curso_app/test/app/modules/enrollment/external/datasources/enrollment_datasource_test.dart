import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vr_curso_app/app/core/shared/services/client_http/dio_client_http.dart';
import 'package:vr_curso_app/app/core/shared/services/client_http/i_client_http.dart';
import 'package:vr_curso_app/app/core/value/const_http.dart';
import 'package:vr_curso_app/app/modules/enrollment/exception/enrollment_exception.dart';
import 'package:vr_curso_app/app/modules/enrollment/external/datasources/enrollment_datasource.dart';
import 'package:vr_curso_app/app/modules/enrollment/infra/adapters/enrollment_adapter.dart';
import 'package:vr_curso_app/app/modules/enrollment/infra/datasources/i_enrollment_datasourse.dart';

import '../../../../mocks/mocks.dart';

class ClientHttpMock extends Mock implements DioClientHttp {}

void main() {
  late IClientHttp client;
  late IEnrollmentDatasource datasource;

  setUp(() {
    client = ClientHttpMock(); // Mock implementation of IClientHttp
    datasource = EnrollmentDatasource(client);
  });

  group('Enrollment Datasource Happy path ;]', () {
    test('Should return a List<Map<String, dynamic>> of enrollments...',
        () async {
                const url = ConstHttp.enrollments;

      when(() => client.get(url)).thenAnswer(
        (_) async => BaseResponse(
          mockLstEnrollmentsData,
          BaseRequest(
            data: {},
            method: 'get',
            headers: {},
            url: url,
          ),
          200,
        ),
      );

      final enrollmentList = await datasource.getAll();

      expect(enrollmentList, isA<List<Map<String, dynamic>>>());
    });

    test('Should return a list of enrollments with 2 entries...', () async {
      const url = ConstHttp.enrollments;
      when(() => client.get(url)).thenAnswer(
        (_) async => BaseResponse(
          mockEnrollmentData,
          BaseRequest(
            data: {},
            method: 'get',
            headers: {},
            url: url,
          ),
          200,
        ),
      );

      final enrollment = await datasource.getAll();

      expect(enrollment,isA<Map<String,dynamic>>());
    });

    test('Should return Map<String, dynamic> with enrollment data...',
        () async {
        const url = '${ConstHttp.enrollments}1';
      when(() => client.get(url)).thenAnswer(
        (_) async => BaseResponse(
          mockEnrollmentData,
          BaseRequest(
            data: {},
            method: 'get',
            headers: {},
            url: url,
          ),
          200,
        ),
      );

      final enrollment = await datasource.get(enrollmenDtoMock);

      expect(enrollment, isA<Map<String, dynamic>>());
    });

    test('Should return the student name as John Doe...', () async {
         const url = '${ConstHttp.enrollments}1';
      when(() => client.get(url)).thenAnswer(
        (_) async => BaseResponse(
          mockEnrollmentData,
          BaseRequest(
            data: {},
            method: 'get',
            headers: {},
            url: url,
          ),
          200,
        ),
      );

      final enrollment = await datasource.get(enrollmenDtoMock);

      expect(enrollment['codigo'],1);
    });

    test('Should create a new enrollment and return Map...', () async {
         const url = ConstHttp.enrollments;
      final param = EnrollmentAdapter.toMap(enrollmenDtoMock.entity);

      when(() => client.post(url, data: param)).thenAnswer(
        (_) async => BaseResponse(
          mockEnrollmentData,
          BaseRequest(
            data: param,
            method: 'post',
            headers: {},
            url: url,
          ),
          201,
        ),
      );

      final result = await datasource.create(enrollmenDtoMock);

      expect(result, isA<Map<String, dynamic>>());
    });

    test('Should update an existing enrollment...', () async {
          const url = '${ConstHttp.enrollments}1';
      final param = EnrollmentAdapter.toMap(enrollmenDtoMock.entity);

      when(() => client.put(url, data: param)).thenAnswer(
        (_) async => BaseResponse(
          {},
          BaseRequest(
            data: param,
            method: 'put',
            headers: {},
            url: url,
          ),
          200,
        ),
      );

      expect(datasource.update(enrollmenDtoMock), completes);
    });

    test('Should delete an enrollment and return true...', () async {
           const url = '${ConstHttp.enrollments}1';

      when(() => client.delete(url)).thenAnswer(
        (_) async => BaseResponse(
          {},
          BaseRequest(
            data: {},
            method: 'delete',
            headers: {},
            url: url,
          ),
          204,
        ),
      );

      final result = await datasource.delete(enrollmenDtoMock);

      expect(result, true);
    });
  });

  group('Enrollment Datasource Sad path :[', () {
    test('Should return EnrollmentException on failure to fetch enrollments...',
        () async {
      const url = ConstHttp.enrollments;
      when(() => client.get(url)).thenAnswer(
        (_) async => BaseResponse(
          {},
          BaseRequest(
            data: {},
            method: 'get',
            headers: {},
            url: url,
          ),
          403,
        ),
      );

      final future = await datasource.getAll();

      expect(future, isA<EnrollmentException>());
    });

    test(
        'Should return EnrollmentException on failure to fetch an enrollment...',
        () async {
     const url = '${ConstHttp.enrollments}-1';

      when(() => client.get(url)).thenAnswer(
        (_) async => Future.value(BaseResponse(
          {}, // Empty response body
          BaseRequest(
            data: {},
            method: 'get',
            headers: {},
            url: url,
          ),
          403, // Forbidden status code
        )),
      );

      final future = await datasource.get(enrollmenDtoEmptyMock);

      expect(future, isA<EnrollmentException>());
    });

    test(
        'Should return EnrollmentException on failure to create an enrollment...',
        () async {
     const url = ConstHttp.enrollments;
      final param = EnrollmentAdapter.toMap(enrollmenDtoEmptyMock.entity);

      when(() => client.post(url, data: param)).thenAnswer(
        (_) async => BaseResponse(
          {},
          BaseRequest(
            data: {},
            method: 'post',
            headers: {},
            url: url,
          ),
          403,
        ),
      );

      final future = await datasource.create(enrollmenDtoEmptyMock);

      expect(future, isA<EnrollmentException>());
    });

    test(
        'Should return EnrollmentException on failure to update an enrollment...',
        () async {
     const url = '${ConstHttp.enrollments}-1';
      final param = EnrollmentAdapter.toMap(enrollmenDtoEmptyMock.entity);

      when(() => client.put(url, data: param)).thenAnswer(
        (_) async => BaseResponse(
          {},
          BaseRequest(
            data: {},
            method: 'put',
            headers: {},
            url: url,
          ),
          403,
        ),
      );

      final future = await datasource.update(enrollmenDtoEmptyMock);

      expect(future, isA<EnrollmentException>());
    });

    test(
        'Should return EnrollmentException on failure to delete an enrollment...',
        () async {
      const url = '${ConstHttp.enrollments}-1';

      when(() => client.delete(url)).thenAnswer(
        (_) async => BaseResponse(
          {},
          BaseRequest(
            data: {},
            method: 'delete',
            headers: {},
            url: url,
          ),
          403,
        ),
      );

      final future = await datasource.delete(enrollmenDtoEmptyMock);

      expect(future, isA<EnrollmentException>());
    });
  });
}
