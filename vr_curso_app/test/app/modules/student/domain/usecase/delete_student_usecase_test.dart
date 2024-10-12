import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vr_curso_app/app/core/types/either.dart';
import 'package:vr_curso_app/app/modules/student/domain/i_repository/i_student_repository.dart';
import 'package:vr_curso_app/app/modules/student/domain/usecase/delete_student_usecase.dart';
import 'package:vr_curso_app/app/modules/student/exception/student_exception.dart';

class StudentRepositoryMock extends Mock implements IStudentRepository {}

void main() {
  late IStudentRepository repository;

  setUp(() {
    repository = StudentRepositoryMock();
  });

  group('Caminho Feliz ;]', () {
    test('Deve deletar um StudentEntity ...', () async {
      // Arrange
      const idMock = '1'; // ID mockado válido
      when(() => repository.delete(idMock)).thenAnswer(
        (_) async => right(true), // Retorna sucesso
      );

      // Act
      final usecase = DeleteStudentUsecase(repository);

      // Assert
      expect(usecase(idMock), completes);
    });

    test('Deve retornar void após deletar um StudentEntity ...', () async {
      // Arrange
      const idMock = '1'; // ID mockado válido
      when(() => repository.delete(idMock)).thenAnswer(
        (_) async => right(true), // Retorna sucesso
      );

      // Act
      final usecase = DeleteStudentUsecase(repository);
      final result = await usecase.call(idMock);

      // Assert
      expect(result.fold((l) => l, (r) => null), isA<void>());
    });
  });

  group('Caminho Triste :[', () {
    test('Deve completar chamada mesmo com id vazio ...', () async {
      // Arrange
      const emptyId = ''; // ID vazio
      when(() => repository.delete(emptyId)).thenAnswer(
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
      expect(usecase(emptyId), completes);
    });

    test('Deve retornar StudentException caso o id esteja vazio ...', () async {
      // Arrange
      const emptyId = ''; // ID vazio
      when(() => repository.delete(emptyId)).thenAnswer(
        (_) async => left(
          const StudentException(
            message: 'ERROR: O Parametro esta vazio',
            stackTrace: StackTrace.empty,
          ),
        ),
      );

      // Act
      final usecase = DeleteStudentUsecase(repository);
      final result = await usecase.call(emptyId);

      // Assert
      expect(result.fold((l) => l, (r) => null), isA<StudentException>());
    });
  });
}
