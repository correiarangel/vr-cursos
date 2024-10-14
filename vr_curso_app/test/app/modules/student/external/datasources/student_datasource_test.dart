import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vr_curso_app/app/core/shared/services/client_http/dio_client_http.dart';
import 'package:vr_curso_app/app/core/shared/services/client_http/i_client_http.dart';
import 'package:vr_curso_app/app/core/value/const_http.dart';
import 'package:vr_curso_app/app/modules/student/exception/student_exception.dart';
import 'package:vr_curso_app/app/modules/student/external/datasources/student_datasource.dart';
import 'package:vr_curso_app/app/modules/student/infra/adapters/student_adapter.dart';
import 'package:vr_curso_app/app/modules/student/infra/datasources/i_student_datasource.dart';

import '../../../../mocks/mocks.dart';

class ClientHttpMock extends Mock implements DioClientHttp {}

const mockStudentsData = [
  {'codigo': 1, 'nome': 'John', 'alunoCodigosMatriculas': []},
  {'codigo': 2, 'nome': 'John 2', 'alunoCodigosMatriculas': []}
];
final mockStudentDataMap = {
  'codigo': 1,
  'nome': 'John',
  'alunoCodigosMatriculas': []
};

void main() {
  late IClientHttp client;
  late IStudentDatasource datasource;

  setUp(() {
    debugPrint('Starting tests...');
    client = ClientHttpMock(); // Mock implementation of IClientHttp
    datasource = StudentDatasource(client);
  });

  group('Student Datasource Happy path ;]', () {
    test('Should return a List<Map<String, dynamic>> of students...', () async {
      var url = ConstHttp.students;
      when(() => client.get(url)).thenAnswer(
        (_) async => BaseResponse(
          mockStudentsData,
          BaseRequest(
            data: {},
            method: 'get',
            headers: {},
            url: url,
          ),
          200,
        ),
      );

      final studentList = await datasource.getAll();

      expect(studentList, isA<List<Map<String, dynamic>>>());
    });

    test('Should return a list of students with 2 entries...', () async {
      var url = ConstHttp.students;
      when(() => client.get(url)).thenAnswer(
        (_) async => BaseResponse(
          mockStudentsData,
          BaseRequest(
            data: {},
            method: 'get',
            headers: {},
            url: url,
          ),
          200,
        ),
      );

      final studentList = await datasource.getAll();

      expect(studentList.length, 2);
    });

    test('Should return Map<String, dynamic> with student data...', () async {
      var url = '${ConstHttp.students}1';
      when(() => client.get(url)).thenAnswer(
        (_) async => BaseResponse(
          mockStudentDataMap,
          BaseRequest(
            data: {},
            method: 'get',
            headers: {},
            url: url,
          ),
          200,
        ),
      );

      final student = await datasource.get(dtoMOCK);

      expect(student, isA<Map<String, dynamic>>());
    });

    test('Should return the student name as John...', () async {
      var url = '${ConstHttp.students}1';
      when(() => client.get(url)).thenAnswer(
        (_) async => BaseResponse(
          mockStudentDataMap,
          BaseRequest(
            data: {},
            method: 'get',
            headers: {},
            url: url,
          ),
          200,
        ),
      );

      final student = await datasource.get(dtoMOCK);

      expect(student['nome'], 'John');
    });

    test('Should create a new student and return Map...', () async {
      var url = ConstHttp.students;
      final param = StudentAdapter.toMap(studentEntityMock);

      when(() => client.post(url, data: param)).thenAnswer(
        (_) async => BaseResponse(
          mockStudentDataMap,
          BaseRequest(
            data: param,
            method: 'post',
            headers: {},
            url: url,
          ),
          201,
        ),
      );

      final result = await datasource.create(dtoMOCK);

      expect(result, isA<Map<String, dynamic>>());
    });

    test('Should update an existing student...', () async {
      var url = '${ConstHttp.students}1';
      final param = StudentAdapter.toMap(studentEntityMock);

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

      expect(datasource.update(dtoMOCK), completes);
    });

    test('Should delete a student and return true...', () async {
      var url = '${ConstHttp.students}1';

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

      final result = await datasource.delete(dtoMOCK);

      expect(result, true);
    });
  });

  group('Student Datasource Sad path :[', () {
    test('Should return StudentException on failure to fetch students...',
        () async {
      var url = ConstHttp.students;
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

      expect(future, isA<StudentException>());
    });

    test('Should return StudentException on failure to fetch a student...',
        () async {
      var url = '${ConstHttp.students}-1';

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

      final future = await datasource.get(dtoEntityMOCK);

      expect(future, isA<StudentException>());
    });

    test('Should return StudentException on failure to create a student...',
        () async {
      var url = ConstHttp.students;
      final param = StudentAdapter.toMap(dtoEntityMOCK.entity);

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

      final future = await datasource.create(dtoEntityMOCK);

      expect(future, isA<StudentException>());
    });

    test('Should return StudentException on failure to update a student...',
        () async {
      var url = '${ConstHttp.students}-1';
      final param = StudentAdapter.toMap(dtoEntityMOCK.entity);

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

      final future = await datasource.update(dtoEntityMOCK);

      expect(future, isA<StudentException>());
    });

    test('Should return StudentException on failure to delete a student...',
        () async {
      var url = '${ConstHttp.students}-1';

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

      final future = await datasource.delete(dtoEntityMOCK);

      expect(future, isA<StudentException>());
    });
  });
}
