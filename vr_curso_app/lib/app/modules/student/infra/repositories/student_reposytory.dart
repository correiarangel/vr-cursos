import 'package:vr_curso_app/app/core/types/either.dart';
import 'package:vr_curso_app/app/modules/student/domain/entities/student_entity.dart';
import 'package:vr_curso_app/app/modules/student/domain/student_dto/student_dto.dart';
import 'package:vr_curso_app/app/modules/student/exception/student_exception.dart';
import 'package:vr_curso_app/app/modules/student/domain/i_repository/i_student_repository.dart';
import 'package:vr_curso_app/app/modules/student/infra/adapters/student_adapter.dart';

import '../datasources/i_student_datasource.dart';

class StudentRepository implements IStudentRepository {
  final IStudentDatasource datasource;

  StudentRepository(this.datasource);

  @override
  Future<Either<IStudentException, List<StudentEntity>>> getAll() async {
    try {
      final result = await datasource.getAll();

      if (result is IStudentException) {
        return left(StudentException(
          message: 'No students returned!',
          stackTrace: StackTrace.current,
        ));
      }

      final mapResp = result as List;
      final listStudent =
          mapResp.map((map) => StudentAdapter.fromMap(map)).toList();
      return right(listStudent);
    } on StudentException catch (error, stackTrace) {
      return left(StudentException(
        message: 'Error fetching students: $error',
        stackTrace: stackTrace,
      ));
    } on Exception catch (error, stackTrace) {
      return left(StudentException(
        message: 'Unexpected error fetching students: $error',
        stackTrace: stackTrace,
      ));
    }
  }

  @override
  Future<Either<IStudentException, StudentEntity>> create(
    StudentDTO param,
  ) async {
    try {
      final result = await datasource.create(param);

      if (result is Map<String, dynamic>) {
        final student = StudentAdapter.fromMap(result);
        return right(student);
      }
      return left(StudentException(
        message: 'Failed to register student!',
        stackTrace: StackTrace.current,
      ));
    } on StudentException catch (error, stackTrace) {
      return left(StudentException(
        message: 'Error creating student: $error',
        stackTrace: stackTrace,
      ));
    } on Exception catch (error, stackTrace) {
      return left(StudentException(
        message: 'Unexpected error creating student: $error',
        stackTrace: stackTrace,
      ));
    }
  }

  @override
  Future<Either<IStudentException, StudentEntity>> update(
      StudentDTO param) async {
    try {
      final result = await datasource.update(param);

      if (result is Map<String, dynamic>) {
        final student = StudentAdapter.fromMap(result);
        return right(student);
      }
      return left(StudentException(
        message: 'Failed to update student!',
        stackTrace: StackTrace.current,
      ));
    } on StudentException catch (error, stackTrace) {
      return left(StudentException(
        message: 'Error updating student: $error',
        stackTrace: stackTrace,
      ));
    } on Exception catch (error, stackTrace) {
      return left(StudentException(
        message: 'Unexpected error updating student: $error',
        stackTrace: stackTrace,
      ));
    }
  }

  @override
  Future<Either<IStudentException, StudentEntity>> get(StudentDTO param) async {
    try {
      final result = await datasource.get(param);

      if (result is Map<String, dynamic>) {
        return right(StudentAdapter.fromMap(result));
      }
      return left(StudentException(
        message: 'Student not found!',
        stackTrace: StackTrace.current,
      ));
    } on StudentException catch (error, stackTrace) {
      return left(StudentException(
        message: 'Error fetching student by ID: $error',
        stackTrace: stackTrace,
      ));
    } on Exception catch (error, stackTrace) {
      return left(StudentException(
        message: 'Unexpected error fetching student by ID: $error',
        stackTrace: stackTrace,
      ));
    }
  }

  @override
  Future<Either<IStudentException, bool>> delete(StudentDTO param) async {
    try {
      final result = await datasource.delete(param);

      if (result is IStudentException) {
        return left(StudentException(
          message: 'Failed to delete student!',
          stackTrace: StackTrace.current,
        ));
      }

      return right(true);
    } on StudentException catch (error, stackTrace) {
      return left(StudentException(
        message: 'Error deleting student: $error',
        stackTrace: stackTrace,
      ));
    } on Exception catch (error, stackTrace) {
      return left(StudentException(
        message: 'Unexpected error deleting student: $error',
        stackTrace: stackTrace,
      ));
    }
  }
}
