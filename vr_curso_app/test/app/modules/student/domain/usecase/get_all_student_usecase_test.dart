import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vr_curso_app/app/core/types/either.dart';
import 'package:vr_curso_app/app/modules/student/domain/entities/student_entity.dart';
import 'package:vr_curso_app/app/modules/student/domain/i_repository/i_student_repository.dart';
import 'package:vr_curso_app/app/modules/student/domain/usecase/get_all_student_usecase.dart';
import 'package:vr_curso_app/app/modules/student/exception/student_exception.dart';

// Importe suas classes e entidades aqui

class StudentRepositoryMock extends Mock implements IStudentRepository {}

void main() {
  late IStudentRepository repository;
  late IStudentException exception;

  setUpAll(() {
    exception = const StudentException(message: 'Error', stackTrace: null);
  });

  setUp(() {
    repository = StudentRepositoryMock();
  });

  group('Caminho Feliz :]', () {
    test('Deve completar chamada do usecase', () async {
      // Arrange
      when(() => repository.getAll())
          .thenAnswer((_) async => right([StudentEntity(name: 'John', id: -1)]));

      final usecase = GetAllStudentUsecase(repository);

      // Act & Assert
      expect(usecase(), completes);
    });

    test('Deve retornar lista de StudentEntity', () async {
      // Arrange
      when(() => repository.getAll())
          .thenAnswer((_) async => right([StudentEntity(name: 'John', id: -1)]));

      final usecase = GetAllStudentUsecase(repository);

      // Act
      final result = await usecase();

      // Assert
      expect(result.fold((l) => l, (r) => r), isA<List<StudentEntity>>());
    });
  });

  group('Caminho Triste :[', () {
    test('Deve retornar Left em caso de exceção', () async {
      // Arrange
      when(() => repository.getAll())
          .thenAnswer((_) async => left(exception));

      final usecase = GetAllStudentUsecase(repository);

      // Act
      final result = await usecase();

      // Assert
      expect(result.isLeft, true);
    });

    test('Deve retornar StudentException em caso de erro', () async {
      // Arrange
      when(() => repository.getAll())
          .thenAnswer((_) async => left(exception));

      final usecase = GetAllStudentUsecase(repository);

      // Act
      final result = await usecase();

      // Assert
      expect(result.fold((l) => l, (r) => r), isA<StudentException>());
    });
  });
}
