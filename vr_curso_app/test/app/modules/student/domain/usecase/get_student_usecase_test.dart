import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vr_curso_app/app/core/types/either.dart';
import 'package:vr_curso_app/app/modules/student/domain/entities/student_entity.dart';
import 'package:vr_curso_app/app/modules/student/domain/i_repository/i_student_repository.dart';
import 'package:vr_curso_app/app/modules/student/domain/usecase/get_student_usecase.dart';
import 'package:vr_curso_app/app/modules/student/exception/student_exception.dart';

import '../../../../mocks/mocks.dart';


// Importe suas classes e entidades aqui
// Exemplo: import 'package:your_project/student.dart';

class StudentRepositoryMock extends Mock implements IStudentRepository {}

void main() {
  late IStudentRepository repository;

  setUp(() {
    repository = StudentRepositoryMock();
  });

  group('Get Student  Caminho Feliz ;]', () {
    test('Deve completar chamada para obter um StudentEntity ...', () async {
      // Arrange
      when(() => repository.get(dtoMOCK)).thenAnswer(
        (_) async =>
            right(StudentEntity(name: 'John Doe', id: -1, enrollmentIds: [])),
      );

      final usecase = GetStudentUsecase(repository);

      // Act & Assert
      expect(usecase(dtoMOCK), completes);
    });

    test('Deve retornar um StudentEntity ...', () async {
      // Arrange
      when(() => repository.get(dtoMOCK)).thenAnswer(
        (_) async =>
            right(dtoMOCK.entity),
      );

      final usecase = GetStudentUsecase(repository);

      // Act
      final result = await usecase(dtoMOCK);

      // Assert
      expect(result.fold((l) => l, (r) => r), isA<StudentEntity>());
    });
  });

  group('Get Student  Caminho Triste :[', () {
    test('Deve completar chamada mesmo com id vazio ...', () async {
      // Arrange
      when(() => repository.get(dtoEntityMOCK)).thenAnswer(
        (_) async => left(
          const StudentException(
            message: 'ERROR: O Parametro está vazio',
            stackTrace: null,
          ),
        ),
      );

      final usecase = GetStudentUsecase(repository);

      // Act & Assert
      expect(usecase(dtoEntityMOCK), completes);
    });

    test('Deve retornar StudentException em caso de erro com id vazio ...',
        () async {
      // Arrange
      when(() => repository.get(dtoEntityMOCK)).thenAnswer(
        (_) async => left(
          const StudentException(
            message: 'ERROR: O Parametro está vazio',
            stackTrace: null,
          ),
        ),
      );

      final usecase = GetStudentUsecase(repository);

      // Act
      final result = await usecase(dtoEntityMOCK);

      // Assert
      expect(result.fold((l) => l, (r) => r), isA<StudentException>());
    });
  });
}
