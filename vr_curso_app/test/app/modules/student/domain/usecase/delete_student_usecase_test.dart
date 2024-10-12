import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vr_curso_app/app/core/types/either.dart';
import 'package:vr_curso_app/app/modules/student/domain/i_repository/i_student_repository.dart';
import 'package:vr_curso_app/app/modules/student/domain/usecase/delete_student_usecase.dart';
import 'package:vr_curso_app/app/modules/student/exception/student_exception.dart';

import '../../../../mocks/mocks.dart';

class StudentRepositoryMock extends Mock implements IStudentRepository {}

void main() {
  late IStudentRepository repository;

  setUp(() {
    repository = StudentRepositoryMock();
  });

  group('Delete Student Caminho Feliz ;]', () {
    test('Deve deletar um StudentEntity ...', () async {
      // Arrange

      when(() => repository.delete(dtoMOCK)).thenAnswer(
        (_) async => right(true), // Retorna sucesso
      );

      // Act
      final usecase = DeleteStudentUsecase(repository);

      // Assert
      expect(usecase.call(dtoMOCK), completes);
    });

    test('Deve retornar void após deletar um StudentEntity ...', () async {
      // Arrange

      when(() => repository.delete(dtoMOCK)).thenAnswer(
        (_) async => right(true), // Retorna sucesso
      );

      // Act
      final usecase = DeleteStudentUsecase(repository);
      final result = await usecase.call(dtoMOCK);

      // Assert
      expect(result.fold((l) => l, (r) => null), isA<void>());
    });
  });

  group('Delete Student Caminho Triste :[', () {
    test('Deve completar chamada mesmo com id = -1  ...', () async {
      // Arrange

      when(() => repository.delete(dtoEntityMOCK)).thenAnswer(
        (_) async => left(
          const StudentException(
            message: 'ERROR: O Parametro esta vazio',
            stackTrace: StackTrace.empty,
          ),
        ),
      );

      // Act
      final usecase = DeleteStudentUsecase(repository);

      // Assert
      expect(usecase(dtoEntityMOCK), completes);
    });

    test('Deve retornar StudentException caso id = -1 ...', () async {
      // Arrange
 
      when(() => repository.delete(dtoEntityMOCK)).thenAnswer(
        (_) async => left(
          const StudentException(
            message: 'ERROR: O Parametro esta vazio',
            stackTrace: StackTrace.empty,
          ),
        ),
      );

      // Act
      final usecase = DeleteStudentUsecase(repository);
      final result = await usecase.call(dtoEntityMOCK);

      // Assert
      expect(result.fold((l) => l, (r) => null), isA<StudentException>());
    });
  });
}
