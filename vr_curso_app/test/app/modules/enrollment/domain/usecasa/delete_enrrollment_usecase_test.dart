import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vr_curso_app/app/core/types/either.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/repositories/i_enrrollment_repository.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/usecasa/delete_enrrollment_usecase.dart';
import 'package:vr_curso_app/app/modules/enrollment/exception/enrollment_exception.dart';

import '../../../../mocks/mocks.dart';
import 'create_enrrollment_usecase_test.dart';

void main() {
  late IEnrollmentRepository repository;

  setUp(() {
    repository = EnrollmentRepositoryMock(); // Mock do repositório de matrícula
  });

  group('Delete Enrollment Happy Path ;]', () {
    test('Should delete an EnrollmentEntity ...', () async {
      // Arrange
      when(() => repository.delete(enrollmenDtoMock)).thenAnswer(
        (_) async => right(true), // Retorna sucesso
      );

      // Act
      final usecase = DeleteEnrollmentUsecase(repository);

      // Assert
      expect(usecase.call(enrollmenDtoMock), completes);
    });

    test('Should return void after deleting an EnrollmentEntity ...', () async {
      // Arrange
      when(() => repository.delete(enrollmenDtoMock)).thenAnswer(
        (_) async => right(true), // Retorna sucesso
      );

      // Act
      final usecase = DeleteEnrollmentUsecase(repository);
      final result = await usecase.call(enrollmenDtoMock);

      // Assert
      expect(result.fold((l) => l, (r) => r), true);
    });
  });

  group('Delete Enrollment Sad Path :[', () {
    test('Should complete the call even with id = -1 ...', () async {
      // Arrange
      when(() => repository.delete(enrollmenDtoMock)).thenAnswer(
        (_) async => left(
          const EnrollmentException(
            message: 'ERROR: Invalid or empty enrollment ID.',
            stackTrace: StackTrace.empty,
          ),
        ),
      );

      // Act
      final usecase = DeleteEnrollmentUsecase(repository);

      // Assert
      expect(usecase(enrollmenDtoMock), completes);
    });

    test('Should return EnrollmentException if id = -1 ...', () async {
      // Arrange
      when(() => repository.delete(enrollmenDtoEmptyMock)).thenAnswer(
        (_) async => left(
          const EnrollmentException(
            message: 'ERROR: Invalid or empty enrollment ID.',
            stackTrace: StackTrace.empty,
          ),
        ),
      );

      // Act
      final usecase = DeleteEnrollmentUsecase(repository);
      final result = await usecase.call(enrollmenDtoEmptyMock);

      // Assert
      expect(result.fold((l) => l, (r) => r), isA<EnrollmentException>());
    });
  });
}
