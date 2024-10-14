import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vr_curso_app/app/core/types/either.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/entities/enrollment_entity.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/repositories/i_enrrollment_repository.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/usecasa/create_enrrollment_usecase.dart';
import 'package:vr_curso_app/app/modules/enrollment/exception/enrollment_exception.dart';

import '../../../../mocks/mocks.dart';


// Mocks
class EnrollmentRepositoryMock extends Mock implements IEnrollmentRepository {}


// Main test
void main() {
  late IEnrollmentRepository repository;
  late CreateEnrollmentUsecase usecase;

  setUp(() {
    repository = EnrollmentRepositoryMock();
    usecase = CreateEnrollmentUsecase(repository);
  });

  group('Create Enrollment Happy Path ;]', () {
    test('Should complete the call to add a new EnrollmentEntity ...', () async {
      // Arrange
      when(() => repository.create(enrollmenDtoMock)).thenAnswer(
        (_) async => right(enrollmenEntityMock), // Returning the correct type
      );

      // Act & Assert
      expect(usecase.call(param: enrollmenDtoMock), completes);
    });

    test('Should return EnrollmentEntity correctly ...', () async {
      // Arrange
      when(() => repository.create(enrollmenDtoMock)).thenAnswer(
        (_) async => right(enrollmenEntityMock),
      );

      // Act
      final result = await usecase.call(param: enrollmenDtoMock);

      // Assert
      expect(result.fold((l) => l, (r) => r), isA<EnrollmentEntity>());
    });
  });

  group('Create Enrollment Sad Path :[', () {
    test('Should return EnrollmentException if the EnrollmentObject is not valid (invalid student or course) ...', () async {
      // Arrange
      when(() => repository.create(enrollmenDtoMock)).thenAnswer(
        (_) async => left(
          const EnrollmentException(
            message: 'ERROR: Student or Course is missing.',
            stackTrace: StackTrace.empty,
          ),
        ),
      );

      // Act
      final result = await usecase.call(param: enrollmenDtoMock);

      // Assert
      expect(result.fold((l) => l, (r) => null), isA<EnrollmentException>());
    });

    test('Should complete the call even with invalid data (student or course missing) ...', () async {
      // Arrange: mockando um DTO com dados inválidos
      when(() => repository.create(enrollmenDtoEmptyMock)).thenAnswer(
        (_) async => left(
          const EnrollmentException(
            message: 'ERROR: Student or Course is missing.',
            stackTrace: StackTrace.empty,
          ),
        ),
      );

      // Act & Assert
      expect(usecase.call(param:enrollmenDtoEmptyMock), completes);
    });

    test('Should return EnrollmentException if the student ID is invalid ...', () async {
      // Arrange
      when(() => repository.create(enrollmenDtoEmptyMock)).thenAnswer(
        (_) async => left(
          const EnrollmentException(
            message: 'ERROR: Student ID is invalid',
            stackTrace: StackTrace.empty,
          ),
        ),
      );

      // Act
      final result = await usecase.call(param: enrollmenDtoEmptyMock);

      // Assert
      expect(result.fold((l) => l, (r) => null), isA<EnrollmentException>());
    });
  });
}
