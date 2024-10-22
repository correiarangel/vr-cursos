import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vr_curso_app/app/core/shared/services/client_http/dio_client_http.dart';
import 'package:vr_curso_app/app/core/shared/services/client_http/i_client_http.dart';
import 'package:vr_curso_app/app/core/value/const_http.dart';
import 'package:vr_curso_app/app/modules/course/exception/course_exception.dart';
import 'package:vr_curso_app/app/modules/course/external/datasources/course_datasource.dart';
import 'package:vr_curso_app/app/modules/course/infra/adapters/cuorse_adapter.dart';
import 'package:vr_curso_app/app/modules/course/infra/datasources/i_course_datasourse.dart';

import '../../../../mocks/mocks.dart';

class ClientHttpMock extends Mock implements DioClientHttp {}


const mockCoursesData = [
  {'codigo': 1, 'nome': 'Mathematics', 'descricao': 'Basic Math'},
  {'codigo': 2, 'nome': 'Physics', 'descricao': 'Fundamental Physics'}
];
final mockCourseDataMap = {
  'codigo': 1,
  'nome': 'Mathematics',
  'descricao': 'Basic Math'
};

void main() {
  late IClientHttp client;
  late ICourseDatasource datasource;

  setUp(() {
    debugPrint('Starting tests...');
    client = ClientHttpMock(); // Mock implementation of IClientHttp
    datasource = CourseDatasource(client);
  });

  group('Course Datasource Happy path ;]', () {
    test('Should return a List<Map<String, dynamic>> of courses...', () async {
          const url = ConstHttp.courses;
      when(() => client.get(url)).thenAnswer(
        (_) async => BaseResponse(
          mockCoursesData,
          BaseRequest(
            data: {},
            method: 'get',
            headers: {},
            url: url,
          ),
          200,
        ),
      );

      final courseList = await datasource.getAll();

      expect(courseList, isA<List<Map<String, dynamic>>>());
    });

    test('Should return a list of courses with 2 entries...', () async {
     const url = ConstHttp.courses;
      when(() => client.get(url)).thenAnswer(
        (_) async => BaseResponse(
          mockCoursesData,
          BaseRequest(
            data: {},
            method: 'get',
            headers: {},
            url: url,
          ),
          200,
        ),
      );

      final courseList = await datasource.getAll();

      expect(courseList.length, 2);
    });

    test('Should return Map<String, dynamic> with course data...', () async {
      const url = '${ConstHttp.courses}/1';
      when(() => client.get(url)).thenAnswer(
        (_) async => BaseResponse(
          mockCourseDataMap,
          BaseRequest(
            data: {},
            method: 'get',
            headers: {},
            url: url,
          ),
          200,
        ),
      );

      final course = await datasource.get(courseDTOMock);

      expect(course, isA<Map<String, dynamic>>());
    });

    test('Should return the course name as Mathematics...', () async {
      const url = '${ConstHttp.courses}/1';
      when(() => client.get(url)).thenAnswer(
        (_) async => BaseResponse(
          mockCourseDataMap,
          BaseRequest(
            data: {},
            method: 'get',
            headers: {},
            url: url,
          ),
          200,
        ),
      );

      final course = await datasource.get(courseDTOMock);

      expect(course['nome'], 'Mathematics');
    });

    test('Should create a new course and return Map...', () async {
      const url = ConstHttp.courses;
      
      final param = CourseAdapter.toMap(courseDTOMock.entity);

      when(() => client.post(url, data: param)).thenAnswer(
        (_) async => BaseResponse(
          mockCourseDataMap,
          BaseRequest(
            data: param,
            method: 'post',
            headers: {},
            url: url,
          ),
          200,
        ),
      );

      final result = await datasource.create(courseDTOMock);

      expect(result, isA<Map<String, dynamic>>());
    });

    test('Should update an existing course...', () async {
      const url = '${ConstHttp.courses}/1';
      final param = CourseAdapter.toMap(courseDTOMock.entity);

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

      expect(datasource.update(courseDTOMock), completes);
    });

    test('Should delete a course and return true...', () async {
       const url = '${ConstHttp.courses}/1';

      when(() => client.delete(url)).thenAnswer(
        (_) async => BaseResponse(
          {},
          BaseRequest(
            data: {},
            method: 'delete',
            headers: {},
            url: url,
          ),
          200,
        ),
      );

      final result = await datasource.delete(courseDTOMock);

      expect(result, true);
    });
  });

  group('Course Datasource Sad path :[', () {
    test('Should return CourseException on failure to fetch courses...',
        () async {
    const url = ConstHttp.courses;
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

      expect(future, isA<CourseException>());
    });

    test('Should return CourseException on failure to fetch a course...',
        () async {
      const url = '${ConstHttp.courses}/-1';

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

      final future = await datasource.get(courseDtoEmptyMock);

      expect(future, isA<CourseException>());
    });

    test('Should return CourseException on failure to create a course...',
        () async {
      const url = ConstHttp.courses;
      final param = CourseAdapter.toMap(courseDtoEmptyMock.entity);

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

      final future = await datasource.create(courseDtoEmptyMock);

      expect(future, isA<CourseException>());
    });

    test('Should return CourseException on failure to update a course...',
        () async {
      const url = '${ConstHttp.courses}/-1';
      final param = CourseAdapter.toMap(courseDtoEmptyMock.entity);

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

      final future = await datasource.update(courseDtoEmptyMock);

      expect(future, isA<CourseException>());
    });

    test('Should return CourseException on failure to delete a course...',
        () async {
          const url = '${ConstHttp.courses}/-1';

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

      final future = await datasource.delete(courseDtoEmptyMock);

      expect(future, isA<CourseException>());
    });
  });
}
