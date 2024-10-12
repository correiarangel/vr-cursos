import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vr_curso_app/app/core/types/either.dart';
import 'package:vr_curso_app/app/modules/student/domain/entities/student_entity.dart';
import 'package:vr_curso_app/app/modules/student/domain/i_repository/i_student_repository.dart';
import 'package:vr_curso_app/app/modules/student/domain/usecase/get_student_usecase.dart';
import 'package:vr_curso_app/app/modules/student/exception/student_exception.dart'; // Para o debugPrint

// Importe suas classes e entidades aqui
// Exemplo: import 'package:your_project/student.dart';

class StudentRepositoryMock extends Mock implements IStudentRepository {}

void main() {
  late IStudentRepository repository;

  setUp(() {
    repository = StudentRepositoryMock();
  });

  group('Caminho Feliz ;]', () {
    test('Deve completar chamada para obter um StudentEntity ...', () async {
      // Arrange
      when(() => repository.get('student-id-mock')).thenAnswer(
        (_) async => right(StudentEntity(name: 'John Doe', id: -1)),
      );

      final usecase = GetStudentUsecase(repository);

      // Act & Assert
      expect(usecase('student-id-mock'), completes);
    });

    test('Deve retornar um StudentEntity ...', () async {
      // Arrange
      when(() => repository.get('student-id-mock')).thenAnswer(
        (_) async => right(StudentEntity(name: 'John Doe', id: -1)),
      );

      final usecase = GetStudentUsecase(repository);

      // Act
      final result = await usecase('student-id-mock');

      // Assert
      expect(result.fold((l) => l, (r) => r), isA<StudentEntity>());
    });
  });

  group('Caminho Triste :[', () {
    test('Deve completar chamada mesmo com id vazio ...', () async {
      // Arrange
      when(() => repository.get('')).thenAnswer(
        (_) async => left(
          const StudentException(
            message: 'ERROR: O Parametro está vazio',
            stackTrace: null,
          ),
        ),
      );

      final usecase = GetStudentUsecase(repository);

      // Act & Assert
      expect(usecase(''), completes);
    });

    test('Deve retornar StudentException em caso de erro com id vazio ...', () async {
      // Arrange
      when(() => repository.get('')).thenAnswer(
        (_) async => left(
          const StudentException(
            message: 'ERROR: O Parametro está vazio',
            stackTrace: null,
          ),
        ),
      );

      final usecase = GetStudentUsecase(repository);

      // Act
      final result = await usecase('');

      // Assert
      expect(result.fold((l) => l, (r) => r), isA<StudentException>());
    });
  });
}
