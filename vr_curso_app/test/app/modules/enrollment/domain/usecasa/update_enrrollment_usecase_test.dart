import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vr_curso_app/app/core/types/either.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/entities/enrollment_entity.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/repositories/i_enrrollment_repository.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/usecasa/update_enrrollment_usecase.dart';

import 'package:vr_curso_app/app/modules/enrollment/exception/enrollment_exception.dart';

import '../../../../mocks/mocks.dart';

// Mock do repositório de matrículas
class EnrollmentRepositoryMock extends Mock implements IEnrollmentRepository {}

void main() {
  late IEnrollmentRepository repository;
  late UpdateEnrollmentUsecase usecase;

  setUp(() {
    repository = EnrollmentRepositoryMock();
    usecase = UpdateEnrollmentUsecase(repository);
  });

  group('Update Enrollment Happy Path ;]', () {
    test('Should complete the call to update an EnrollmentEntity ...', () async {
      // Arrange
      when(() => repository.update(enrollmenDtoMock)).thenAnswer(
        (_) async => right(enrollmenDtoMock.entity), // Retornando o tipo correto
      );

      // Act & Assert
      expect(
        usecase.call(enrollmenDtoMock),
        completes,
      );
    });

    test('Should return updated EnrollmentEntity correctly ...', () async {
      // Arrange
      when(() => repository.update(enrollmenDtoMock)).thenAnswer(
        (_) async => right(enrollmenDtoMock.entity), // Retornando o tipo correto
      );

      // Act
      final result = await usecase.call(enrollmenDtoMock);

      // Assert
      expect(result.fold((l) => l, (r) => r), isA<EnrollmentEntity>());
    });
  });

  group('Update Enrollment Sad Path :[', () {
    test('Should return error if the student or course is invalid ...', () async {
      // Arrange
      when(() => repository.update(enrollmenDtoEmptyMock)).thenAnswer(
        (_) async => left(
          const EnrollmentException(
            message: 'ERROR: Student or course is invalid',
            stackTrace: StackTrace.empty,
          ),
        ),
      );

      // Act & Assert
      expect(
        usecase.call(enrollmenDtoEmptyMock),
        completes,
      );
    });

    test('Should return EnrollmentException if the student is invalid ...', () async {
      // Arrange
      when(() => repository.update(enrollmenDtoEmptyMock)).thenAnswer(
        (_) async => left(
          const EnrollmentException(
            message: 'ERROR: Student or course is invalid',
            stackTrace: StackTrace.empty,
          ),
        ),
      );

      // Act
      final result = await usecase.call(enrollmenDtoEmptyMock);

      // Assert
      expect(result.fold((l) => l, (r) => null), isA<EnrollmentException>());
    });
  });
}
