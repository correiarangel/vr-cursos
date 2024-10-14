import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vr_curso_app/app/core/types/either.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/entities/enrollment_entity.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/repositories/i_enrrollment_repository.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/usecasa/get_all_enrrollment_usecase.dart';
import 'package:vr_curso_app/app/modules/enrollment/exception/enrollment_exception.dart';

import '../../../../mocks/mocks.dart';
import 'create_enrrollment_usecase_test.dart';

const exceptionMock =
    EnrollmentException(message: 'Error', stackTrace: StackTrace.empty);

void main() {
  late IEnrollmentRepository repository;

  setUpAll(() {});

  setUp(() {
    repository = EnrollmentRepositoryMock(); 
  });

  group('Get All Enrollments Happy Path :]', () {
    test('Should complete use case call', () async {
      // Arrange
      when(() => repository.getAll())
          .thenAnswer((_) async => right(lstEnrollmenEntityMock)); 

      final usecase = GetAllEnrollmentUsecase(repository);

      // Act & Assert
      expect(usecase.call(), completes); 
    });

    test('Should return list of EnrollmentEntity', () async {
      // Arrange
      when(() => repository.getAll())
          .thenAnswer((_) async => right(lstEnrollmenEntityMock)); // Mock do retorno

      final usecase = GetAllEnrollmentUsecase(repository);

      // Act
      final result = await usecase.call();

      // Assert
      expect(result.fold((l) => l, (r) => r), isA<List<EnrollmentEntity>>()); // Verifica o tipo de retorno
    });
  });

  group('Get All Enrollments Sad Path :[', () {
    test('Should return Left in case of exception', () async {
      // Arrange
      when(() => repository.getAll())
          .thenAnswer((_) async => left(exceptionMock)); // Mock da exceção

      final usecase = GetAllEnrollmentUsecase(repository);

      // Act
      final result = await usecase.call();

      // Assert
      expect(result.isLeft, true); // Verifica se o resultado está à esquerda
    });

    test('Should return EnrollmentException in case of error', () async {
      // Arrange
      when(() => repository.getAll())
          .thenAnswer((_) async => left(exceptionMock)); // Mock da exceção

      final usecase = GetAllEnrollmentUsecase(repository);

      // Act
      final result = await usecase.call();

      // Assert
      expect(result.fold((l) => l, (r) => r), isA<EnrollmentException>()); // Verifica o tipo da exceção
    });
  });
}
