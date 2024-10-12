import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vr_curso_app/app/core/types/either.dart';
import 'package:vr_curso_app/app/modules/student/domain/entities/student_entity.dart';
import 'package:vr_curso_app/app/modules/student/domain/i_repository/i_student_repository.dart';
import 'package:vr_curso_app/app/modules/student/domain/student_dto/student_dto.dart';
import 'package:vr_curso_app/app/modules/student/domain/usecase/create_student_usecase.dart';
import 'package:vr_curso_app/app/modules/student/exception/student_exception.dart';

import '../../../../mocks/mocks.dart';

class StudentRepositoryMock extends Mock implements IStudentRepository {}



void main() {
  late IStudentRepository repository;
  late CreateStudentUsecase usecase;

  setUp(() {
    repository = StudentRepositoryMock();
    usecase = CreateStudentUsecase(repository);
  });

  group('Create Student Caminho Feliz ;]', () {
    test('Deve completar chamada para adicionar um novo StudentEntity ...',
        () async {
      // Arrange
      when(() => repository.create(dtoMOCK)).thenAnswer(
        (_) async => right(studentEntity), // Retornando o tipo correto
      );

      // Act & Assert
      expect(usecase.call(dtoMOCK), completes);
    });
    test('Deve retornar StudentEntity corretamente ...', () async {
      // Arrange
      when(() => repository.create(dtoMOCK)).thenAnswer(
        (_) async => right(studentEntity),
      );

      // Act
      final result = await usecase.call(dtoMOCK);

      // Assert
      expect(result.fold((l) => l, (r) => r), isA<StudentEntity>());
    });
  });

  group('Create Student Caminho Triste :[', () {
    test('Deve completar chamada mesmo com nome vazio ...', () async {
      // Arrange
      when(() => repository.create(dtoMOCK)).thenAnswer(
        (_) async => left(
          const StudentException(
            message: 'ERROR: name está vazio',
            stackTrace: StackTrace.empty,
          ),
        ),
      );

      // Act & Assert
      expect(usecase.call(StudentDTO(entity: emptyEntity)), completes);
    });

    test('Deve retornar StudentException se o nome estiver vazio ...',
        () async {
      // Arrange
      when(() => repository.create(dtoMOCK)).thenAnswer(
        (_) async => left(
          const StudentException(
            message: 'ERROR: name está vazio',
            stackTrace: StackTrace.empty,
          ),
        ),
      );

      // Act
      final result = await usecase.call(StudentDTO(entity: emptyEntity));

      // Assert
      expect(result.fold((l) => l, (r) => null), isA<StudentException>());
    });
  });
}
