


import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vr_curso_app/app/core/types/either.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/entities/enrollment_entity.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/repositories/i_enrrollment_repository.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/usecasa/get_enrrollment_usecase.dart';
import 'package:vr_curso_app/app/modules/enrollment/exception/enrollment_exception.dart';

import '../../../../mocks/mocks.dart';

class EnrollmentRepositoryMock extends Mock implements IEnrollmentRepository {}

void main() {
  late IEnrollmentRepository repository;

  setUp(() {
    repository = EnrollmentRepositoryMock();
  });

  group('Get Enrollment Happy Path :]', () {
    test('Should complete the call to get an EnrollmentEntity ...', () async {
      // Arrange
      when(() => repository.get(enrollmenDtoMock)).thenAnswer(
        (_) async => right(enrollmenDtoMock.entity),
      );

      final usecase = GetEnrollmentUsecase(repository);

      // Act & Assert
      expect(usecase(enrollmenDtoMock), completes);
    });

    test('Should return an EnrollmentEntity ...', () async {
      // Arrange
      when(() => repository.get(enrollmenDtoMock)).thenAnswer(
        (_) async => right(enrollmenDtoMock.entity),
      );

      final usecase = GetEnrollmentUsecase(repository);

      // Act
      final result = await usecase(enrollmenDtoMock);

      // Assert
      expect(result.fold((l) => l, (r) => r), isA<EnrollmentEntity>());
    });
  });

  group('Get Enrollment Sad Path :[', () {
    test('Should complete the call even with an empty id ...', () async {
      // Arrange
      when(() => repository.get(enrollmenDtoEmptyMock)).thenAnswer(
        (_) async => left(
          const EnrollmentException(
            message: 'ERROR: The parameter is empty',
            stackTrace: null,
          ),
        ),
      );

      final usecase = GetEnrollmentUsecase(repository);

      // Act & Assert
      expect(usecase(enrollmenDtoEmptyMock), completes);
    });

    test('Should return EnrollmentException in case of error with empty id ...',
        () async {
      // Arrange
      when(() => repository.get(enrollmenDtoEmptyMock)).thenAnswer(
        (_) async => left(
          const EnrollmentException(
            message: 'ERROR: The parameter is empty',
            stackTrace: null,
          ),
        ),
      );

      final usecase = GetEnrollmentUsecase(repository);

      // Act
      final result = await usecase(enrollmenDtoEmptyMock);

      // Assert
      expect(result.fold((l) => l, (r) => r), isA<EnrollmentException>());
    });
  });
}
