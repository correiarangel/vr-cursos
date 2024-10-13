import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vr_curso_app/app/core/types/either.dart';
import 'package:vr_curso_app/app/modules/course/domain/entities/cuorse_entity.dart';
import 'package:vr_curso_app/app/modules/course/domain/repositories/i_course_repository.dart';

import 'package:vr_curso_app/app/modules/course/exception/course_exception.dart';
import 'package:vr_curso_app/app/modules/course/infra/datasources/i_course_datasourse.dart';
import 'package:vr_curso_app/app/modules/course/infra/repositories/course_reposytory.dart';

import '../../../../mocks/mocks.dart';

// Mock para o ICoursoDatasource
class MockCourseDatasource extends Mock implements ICourseDatasource {}

void main() {
  late MockCourseDatasource mockDatasource;
  late ICourseRepository repository;

  setUp(() {
    mockDatasource = MockCourseDatasource();
    repository = CourseRepository(mockDatasource);
  });

  group('Course Repository - Caminho Feliz', () {
    test('deve retornar uma lista de CourseEntity em getAll com sucesso',
        () async {
      // Arrange
      when(() => mockDatasource.getAll())
          .thenAnswer((_) async => mockCuorsesData);

      // Act
      final result = await repository.getAll();

      // Assert
      expect(result.isRight, true);
      expect(result.fold(id, id), isA<List<CourseEntity>>());
    });

    test('deve retornar CourseEntity em create com sucesso', () async {
      // Arrange
      when(() => mockDatasource.create(courseDTOMock))
          .thenAnswer((_) async => mockCoursetDataMap);

      // Act
      final result = await repository.create(courseDTOMock);

      // Assert
      expect(result.isRight, true);
      expect(result.fold(id, id), isA<CourseEntity>());
    });

    test('deve retornar CourseEntity em update com sucesso', () async {
      // Arrange

      when(() => mockDatasource.update(courseDTOMock))
          .thenAnswer((_) async => mockCoursetDataMap);

      // Act
      final result = await repository.update(courseDTOMock);

      // Assert
      expect(result.isRight, true);
      expect(result.fold(id, id), isA<CourseEntity>());
    });

    test('deve retornar CourseEntity em get com sucesso', () async {
      // Arrange
      final mockResponse = {
        'codigo': 1,
        'nome': 'Course Test',
        'cursoCodigosMatriculas': []
      };
      when(() => mockDatasource.get(courseDTOMock))
          .thenAnswer((_) async => mockResponse);

      // Act
      final result = await repository.get(courseDTOMock);

      // Assert
      expect(result.isRight, true);
      expect(result.fold(id, id), isA<CourseEntity>());
    });

    test('deve retornar true em delete com sucesso', () async {
      // Arrange
      when(() => mockDatasource.delete(courseDTOMock))
          .thenAnswer((_) async => true);

      // Act
      final result = await repository.delete(courseDTOMock);

      // Assert
      expect(result.isRight, true);
      expect(result.fold(id, id), true);
    });
  });

  group('Course Repository - Caminho Triste', () {
    test('deve retornar CourseException em getAll falha', () async {
      // Arrange
      when(() => mockDatasource.getAll()).thenThrow(const CourseException(
          message: 'Error', stackTrace: StackTrace.empty));

      // Act
      final result = await repository.getAll();

      // Assert
      expect(result.isLeft, true);
      expect(result.fold(id, id), isA<CourseException>());
    });

    test('deve retornar CourseException em create falha', () async {
      // Arrange
      when(() => mockDatasource.create(courseDtoEmptyMock)).thenThrow(
          const CourseException(
              message: 'Error', stackTrace: StackTrace.empty));

      // Act
      final result = await repository.create(courseDtoEmptyMock);

      // Assert
      expect(result.isLeft, true);
      expect(result.fold(id, id), isA<CourseException>());
    });

    test('deve retornar CourseException em update falha', () async {
      // Arrange
      when(() => mockDatasource.update(courseDtoEmptyMock)).thenThrow(
          const CourseException(
              message: 'Error', stackTrace: StackTrace.empty));

      // Act
      final result = await repository.update(courseDtoEmptyMock);

      // Assert
      expect(result.isLeft, true);
      expect(result.fold(id, id), isA<CourseException>());
    });

    test('deve retornar CourseException em get falha', () async {
      // Arrange
      when(() => mockDatasource.get(courseDtoEmptyMock)).thenThrow(
          const CourseException(
              message: 'Error', stackTrace: StackTrace.empty));

      // Act
      final result = await repository.get(courseDtoEmptyMock);

      // Assert
      expect(result.isLeft, true);
      expect(result.fold(id, id), isA<CourseException>());
    });

    test('deve retornar CourseException em delete falha', () async {
      // Arrange
      when(() => mockDatasource.delete(courseDtoEmptyMock)).thenThrow(
          const CourseException(
              message: 'Error', stackTrace: StackTrace.empty));

      // Act
      final result = await repository.delete(courseDtoEmptyMock);

      // Assert
      expect(result.isLeft, true);
      expect(result.fold(id, id), isA<CourseException>());
    });
  });
}
