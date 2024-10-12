import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vr_curso_app/app/core/types/either.dart';
import 'package:vr_curso_app/app/modules/student/domain/entities/student_entity.dart';
import 'package:vr_curso_app/app/modules/student/domain/i_repository/i_student_repository.dart';
import 'package:vr_curso_app/app/modules/student/domain/student_dto/student_dto.dart';
import 'package:vr_curso_app/app/modules/student/domain/usecase/update_student_usecase.dart';
import 'package:vr_curso_app/app/modules/student/exception/student_exception.dart';

class StudentRepositoryMock extends Mock implements IStudentRepository {}

final studentEntity = StudentEntity(
  id: 1, // ID válido para o caso de atualização
  name: 'John Doe Updated',
);

final emptyEntity = StudentEntity(
  id: -1,
  name: '', // Nome vazio para testar o erro de validação
);

final dtoMOCK = StudentDTO(
  entity: studentEntity, // Usando entidade válida
);

void main() {
  late IStudentRepository repository;
  late UpdateStudentUsecase usecase;

  setUp(() {
    repository = StudentRepositoryMock();
    usecase = UpdateStudentUsecase(repository);
  });

  group('Caminho Feliz ;]', () {
    test('Deve completar chamada para atualizar um StudentEntity ...', () async {
      // Arrange
      when(() => repository.update(param: dtoMOCK, id: dtoMOCK.entity.id.toString())).thenAnswer(
        (_) async => right(studentEntity), // Retornando o tipo correto
      );

      // Act & Assert
      expect(
        usecase.call(param: dtoMOCK, id: dtoMOCK.entity.id.toString()), 
        completes,
      );
    });

    test('Deve retornar StudentEntity atualizado corretamente ...', () async {
      // Arrange
      when(() => repository.update(param: dtoMOCK, id: dtoMOCK.entity.id.toString())).thenAnswer(
        (_) async => right(studentEntity), // Retornando o tipo correto
      );

      // Act
      final result = await usecase.call(param: dtoMOCK, id: dtoMOCK.entity.id.toString());

      // Assert
      expect(result.fold((l) => l, (r) => r), isA<StudentEntity>());
    });
  });

  group('Caminho Triste :[', () {
    test('Deve retornar erro se o nome ou o ID estiver vazio ...', () async {
      // Arrange
      final invalidDTO = StudentDTO(entity: emptyEntity); // Nome e ID vazios
      when(() => repository.update(param: invalidDTO, id: invalidDTO.entity.id.toString())).thenAnswer(
        (_) async => left(
          const StudentException(
            message: 'ERROR: name está vazio',
            stackTrace: StackTrace.empty,
          ),
        ),
      );

      // Act & Assert
      expect(
        usecase.call(param: invalidDTO, id: invalidDTO.entity.id.toString()), 
        completes,
      );
    });

    test('Deve retornar StudentException se o nome estiver vazio ...', () async {
      // Arrange
      final invalidDTO = StudentDTO(entity: emptyEntity); // Nome vazio
      when(() => repository.update(param: invalidDTO, id: invalidDTO.entity.id.toString())).thenAnswer(
        (_) async => left(
          const StudentException(
            message: 'ERROR: name está vazio',
            stackTrace: StackTrace.empty,
          ),
        ),
      );

      // Act
      final result = await usecase.call(param: invalidDTO, id: invalidDTO.entity.id.toString());

      // Assert
      expect(result.fold((l) => l, (r) => null), isA<StudentException>());
    });
  });
}
