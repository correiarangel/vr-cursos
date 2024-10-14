import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vr_curso_app/app/core/types/either.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/entities/enrollment_entity.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/repositories/i_enrrollment_repository.dart';

import 'package:vr_curso_app/app/modules/enrollment/exception/enrollment_exception.dart';
import 'package:vr_curso_app/app/modules/enrollment/infra/datasources/i_enrollment_datasourse.dart';
import 'package:vr_curso_app/app/modules/enrollment/infra/repositories/enrollment_reposytory.dart';

import '../../../../mocks/mocks.dart';


// Mock for the IEnrollmentDatasource
class MockEnrollmentDatasource extends Mock implements IEnrollmentDatasource {}

void main() {
  late MockEnrollmentDatasource mockDatasource;
  late IEnrollmentRepository repository;

  setUp(() {
    mockDatasource = MockEnrollmentDatasource();
    repository = EnrollmentRepository(mockDatasource);
  });

  group('Enrollment Repository - Happy Path', () {
    test('should return a list of EnrollmentEntity in getAll successfully',
        () async {
      // Arrange
      when(() => mockDatasource.getAll())
          .thenAnswer((_) async => mockLstEnrollmentsData);

      // Act
      final result = await repository.getAll();

      // Assert
      expect(result.isRight, true);
      expect(result.fold(id, id), isA<List<EnrollmentEntity>>());
    });

    test('should return EnrollmentEntity in create successfully', () async {
      // Arrange
      when(() => mockDatasource.create(enrollmenDtoMock))
          .thenAnswer((_) async => mockEnrollmentData);

      // Act
      final result = await repository.create(enrollmenDtoMock);

      // Assert
      expect(result.isRight, true);
      expect(result.fold(id, id), isA<EnrollmentEntity>());
    });

    test('should return EnrollmentEntity in update successfully', () async {
      // Arrange
      when(() => mockDatasource.update(enrollmenDtoMock))
          .thenAnswer((_) async => mockEnrollmentData);

      // Act
      final result = await repository.update(enrollmenDtoMock);

      // Assert
      expect(result.isRight, true);
      expect(result.fold(id, id), isA<EnrollmentEntity>());
    });

    test('should return EnrollmentEntity in get successfully', () async {
      // Arrange

      when(() => mockDatasource.get(enrollmenDtoMock))
          .thenAnswer((_) async => mockEnrollmentData);

      // Act
      final result = await repository.get(enrollmenDtoMock);

      // Assert
      expect(result.isRight, true);
      expect(result.fold(id, id), isA<EnrollmentEntity>());
    });

    test('should return true in delete successfully', () async {
      // Arrange
      when(() => mockDatasource.delete(enrollmenDtoMock))
          .thenAnswer((_) async => true);

      // Act
      final result = await repository.delete(enrollmenDtoMock);

      // Assert
      expect(result.isRight, true);
      expect(result.fold(id, id), true);
    });
  });

  group('Enrollment Repository - Sad Path', () {
    test('should return EnrollmentException in getAll on failure', () async {
      // Arrange
      when(() => mockDatasource.getAll()).thenThrow(const EnrollmentException(
          message: 'Error', stackTrace: StackTrace.empty));

      // Act
      final result = await repository.getAll();

      // Assert
      expect(result.isLeft, true);
      expect(result.fold(id, id), isA<EnrollmentException>());
    });

    test('should return EnrollmentException in create on failure', () async {
      // Arrange
      when(() => mockDatasource.create(enrollmenDtoEmptyMock)).thenThrow(
          const EnrollmentException(
              message: 'Error', stackTrace: StackTrace.empty));

      // Act
      final result = await repository.create(enrollmenDtoEmptyMock);

      // Assert
      expect(result.isLeft, true);
      expect(result.fold(id, id), isA<EnrollmentException>());
    });

    test('should return EnrollmentException in update on failure', () async {
      // Arrange
      when(() => mockDatasource.update(enrollmenDtoEmptyMock)).thenThrow(
          const EnrollmentException(
              message: 'Error', stackTrace: StackTrace.empty));

      // Act
      final result = await repository.update(enrollmenDtoEmptyMock);

      // Assert
      expect(result.isLeft, true);
      expect(result.fold(id, id), isA<EnrollmentException>());
    });

    test('should return EnrollmentException in get on failure', () async {
      // Arrange
      when(() => mockDatasource.get(enrollmenDtoEmptyMock)).thenThrow(
          const EnrollmentException(
              message: 'Error', stackTrace: StackTrace.empty));

      // Act
      final result = await repository.get(enrollmenDtoEmptyMock);

      // Assert
      expect(result.isLeft, true);
      expect(result.fold(id, id), isA<EnrollmentException>());
    });

    test('should return EnrollmentException in delete on failure', () async {
      // Arrange
      when(() => mockDatasource.delete(enrollmenDtoEmptyMock)).thenThrow(
          const EnrollmentException(
              message: 'Error', stackTrace: StackTrace.empty));

      // Act
      final result = await repository.delete(enrollmenDtoEmptyMock);

      // Assert
      expect(result.isLeft, true);
      expect(result.fold(id, id), isA<EnrollmentException>());
    });
  });
}
