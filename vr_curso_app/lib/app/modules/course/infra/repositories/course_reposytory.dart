import 'package:vr_curso_app/app/core/types/either.dart';
import 'package:vr_curso_app/app/modules/course/domain/cuorso_dto/cuorso_dto.dart';
import 'package:vr_curso_app/app/modules/course/domain/entities/cuorse_entity.dart';
import 'package:vr_curso_app/app/modules/course/domain/repositories/i_course_repository.dart';
import 'package:vr_curso_app/app/modules/course/exception/course_exception.dart';
import 'package:vr_curso_app/app/modules/course/infra/adapters/cuorse_adapter.dart';
import 'package:vr_curso_app/app/modules/course/infra/datasources/i_course_datasourse.dart';

class CourseRepository implements ICourseRepository {
  final ICourseDatasource datasource;

  CourseRepository(this.datasource);

  @override
  Future<Either<ICourseException, List<CourseEntity>>> getAll() async {
    try {
      final result = await datasource.getAll();

      if (result is ICourseException) {
        return left(CourseException(
          message: 'Nenhum curso retornado!',
          stackTrace: StackTrace.current,
        ));
      }

      final mapResp = result as List;
      final listCourse =
          mapResp.map((map) => CourseAdapter.fromMap(map)).toList();
      return right(listCourse);
    } on CourseException catch (error, stackTrace) {
      return left(CourseException(
        message: 'Erro ao buscar cursos: $error',
        stackTrace: stackTrace,
      ));
    } on Exception catch (error, stackTrace) {
      return left(CourseException(
        message: 'Erro inesperado ao buscar cursos: $error',
        stackTrace: stackTrace,
      ));
    }
  }

  @override
  Future<Either<ICourseException, CourseEntity>> create(CourseDTO param) async {
    try {
      final result = await datasource.create(param);

      if (result is Map<String, dynamic>) {
        final course = CourseAdapter.fromMap(result);
        return right(course);
      }
      return left(CourseException(
        message: 'Falha ao registrar curso!',
        stackTrace: StackTrace.current,
      ));
    } on CourseException catch (error, stackTrace) {
      return left(CourseException(
        message: 'Erro ao criar curso: $error',
        stackTrace: stackTrace,
      ));
    } on Exception catch (error, stackTrace) {
      return left(CourseException(
        message: 'Erro inesperado ao criar curso: $error',
        stackTrace: stackTrace,
      ));
    }
  }

  @override
  Future<Either<ICourseException, CourseEntity>> update(CourseDTO param) async {
    try {
      final result = await datasource.update(param);

      if (result is Map<String, dynamic>) {
        final course = CourseAdapter.fromMap(result);
        return right(course);
      }
      return left(CourseException(
        message: 'Falha ao atualizar curso!',
        stackTrace: StackTrace.current,
      ));
    } on CourseException catch (error, stackTrace) {
      return left(CourseException(
        message: 'Erro ao atualizar curso: $error',
        stackTrace: stackTrace,
      ));
    } on Exception catch (error, stackTrace) {
      return left(CourseException(
        message: 'Erro inesperado ao atualizar curso: $error',
        stackTrace: stackTrace,
      ));
    }
  }

  @override
  Future<Either<ICourseException, CourseEntity>> get(CourseDTO param) async {
    try {
      final result = await datasource.get(param);

      if (result is Map<String, dynamic>) {
        return right(CourseAdapter.fromMap(result));
      }
      return left(CourseException(
        message: 'Curso não encontrado!',
        stackTrace: StackTrace.current,
      ));
    } on CourseException catch (error, stackTrace) {
      return left(CourseException(
        message: 'Erro ao buscar curso por ID: $error',
        stackTrace: stackTrace,
      ));
    } on Exception catch (error, stackTrace) {
      return left(CourseException(
        message: 'Erro inesperado ao buscar curso por ID: $error',
        stackTrace: stackTrace,
      ));
    }
  }

  @override
  Future<Either<ICourseException, bool>> delete(CourseDTO param) async {
    try {
      final result = await datasource.delete(param);

      if (result is ICourseException) {
        return left(CourseException(
          message: 'Falha ao deletar curso!',
          stackTrace: StackTrace.current,
        ));
      }

      return right(true);
    } on CourseException catch (error, stackTrace) {
      return left(CourseException(
        message: 'Erro ao deletar curso: $error',
        stackTrace: stackTrace,
      ));
    } on Exception catch (error, stackTrace) {
      return left(CourseException(
        message: 'Erro inesperado ao deletar curso: $error',
        stackTrace: stackTrace,
      ));
    }
  }
}
