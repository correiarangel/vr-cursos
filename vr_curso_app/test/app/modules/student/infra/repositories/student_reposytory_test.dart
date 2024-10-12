import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vr_curso_app/app/core/types/either.dart';
import 'package:vr_curso_app/app/modules/student/domain/entities/student_entity.dart';
import 'package:vr_curso_app/app/modules/student/domain/i_repository/i_student_repository.dart';
import 'package:vr_curso_app/app/modules/student/exception/student_exception.dart';
import 'package:vr_curso_app/app/modules/student/infra/datasources/i_student_datasource.dart';
import 'package:vr_curso_app/app/modules/student/infra/repositories/student_reposytory.dart';

import '../../../../mocks/mocks.dart';

// Mock for IStudentDatasource
class MockStudentDatasource extends Mock implements IStudentDatasource {}

void main() {
  late MockStudentDatasource mockDatasource;
  late IStudentRepository repository;

  setUp(() {
    mockDatasource = MockStudentDatasource();
    repository = StudentRepository(mockDatasource);
  });

  group('Student Repository - Caminho Feliz', () {
    test('should return a list of StudentEntity on getAll success', () async {
      // Arrange

      when(() => mockDatasource.getAll())
          .thenAnswer((_) async => mockStudentsData);

      // Act
      final result = await repository.getAll();

      // Assert
      expect(result.isRight, true);
      expect(result.fold(id, id), isA<List<StudentEntity>>());
    });

    test('should return StudentEntity on create success', () async {
      // Arrange

      when(() => mockDatasource.create(dtoMOCK))
          .thenAnswer((_) async => mockStudentDataMap);

      // Act
      final result = await repository.create(dtoMOCK);

      // Assert
      expect(result.isRight, true);
      expect(result.fold(id, id), isA<StudentEntity>());
    });

    test('should return StudentEntity on update success', () async {
      // Arrange
      final mockResponse = {
        'codigo': 1,
        'nome': 'Updated Student',
        'alunoCodigosMatriculas': []
      };
      when(() => mockDatasource.update(dtoMOCK))
          .thenAnswer((_) async => mockResponse);

      // Act
      final result = await repository.update(dtoMOCK);

      // Assert
      expect(result.isRight, true);
      expect(result.fold(id, id), isA<StudentEntity>());
    });

    test('should return StudentEntity on get success', () async {
      // Arrange

      final mockResponse = {
        'codigo': 1,
        'nome': 'Updated Student',
        'alunoCodigosMatriculas': []
      };
      when(() => mockDatasource.get(dtoMOCK))
          .thenAnswer((_) async => mockResponse);

      // Act
      final result = await repository.get(dtoMOCK);

      // Assert
      expect(result.isRight, true);
      expect(result.fold(id, id), isA<StudentEntity>());
    });

    test('should return true on delete success', () async {
      // Arrange
      when(() => mockDatasource.delete(dtoMOCK)).thenAnswer((_) async => true);

      // Act
      final result = await repository.delete(dtoMOCK);

      // Assert
      expect(result.isRight, true);
      expect(result.fold(id, id), true);
    });
  });

  group('Student Repository - Caminho Triste', () {
    test('should return StudentException on getAll failure', () async {
      // Arrange
      when(() => mockDatasource.getAll()).thenThrow(const StudentException(
          message: 'Error', stackTrace: StackTrace.empty));

      // Act
      final result = await repository.getAll();

      // Assert
      expect(result.isLeft, true);
      expect(result.fold(id, id), isA<StudentException>());
    });

    test('should return StudentException on create failure', () async {
      // Arrange
      when(() => mockDatasource.create(dtoMOCK)).thenThrow(
          const StudentException(
              message: 'Error', stackTrace: StackTrace.empty));

      // Act
      final result = await repository.create(dtoMOCK);

      // Assert
      expect(result.isLeft, true);
      expect(result.fold(id, id), isA<StudentException>());
    });
    test('should return StudentException on update failure', () async {
      // Arrange
      when(() => mockDatasource.update(dtoMOCK)).thenThrow(
          const StudentException(
              message: 'Error', stackTrace: StackTrace.empty));

      // Act
      final result = await repository.update(dtoMOCK);

      // Assert
      expect(result.isLeft, true);
      expect(result.fold(id, id), isA<StudentException>());
    });

    test('should return StudentException on get failure', () async {
      // Arrange
      when(() => mockDatasource.get(dtoMOCK)).thenThrow(const StudentException(
          message: 'Error', stackTrace: StackTrace.empty));

      // Act
      final result = await repository.get(dtoMOCK);

      // Assert
      expect(result.isLeft, true);
      expect(result.fold(id, id), isA<StudentException>());
    });

    test('should return StudentException on delete failure', () async {
      // Arrange
      when(() => mockDatasource.delete(dtoMOCK)).thenThrow(
          const StudentException(
              message: 'Error', stackTrace: StackTrace.empty));

      // Act
      final result = await repository.delete(dtoMOCK);

      // Assert
      expect(result.isLeft, true);
      expect(result.fold(id, id), isA<StudentException>());
    });
  });
}
