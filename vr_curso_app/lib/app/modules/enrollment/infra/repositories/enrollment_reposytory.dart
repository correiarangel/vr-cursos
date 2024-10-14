import 'package:vr_curso_app/app/core/types/either.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/entities/enrollment_entity.dart';
import 'package:vr_curso_app/app/modules/enrollment/exception/enrollment_exception.dart';

import '../../domain/params_dto/enrollment_dto.dart';
import '../../domain/repositories/i_enrrollment_repository.dart';
import '../adapters/enrollment_adapter.dart';
import '../datasources/i_enrollment_datasourse.dart';


class EnrollmentRepository implements IEnrollmentRepository {
  final IEnrollmentDatasource datasource;

  EnrollmentRepository(this.datasource);

  @override
  Future<Either<IEnrollmentException, List<EnrollmentEntity>>> getAll() async {
    try {
      final result = await datasource.getAll();

      if (result is IEnrollmentException) {
        return left(EnrollmentException(
          message: 'Nenhuma matrícula retornada!',
          stackTrace: StackTrace.current,
        ));
      }

      final mapResp = result as List;
      final listEnrollment =
          mapResp.map((map) => EnrollmentAdapter.fromMap(map)).toList();
      return right(listEnrollment);
    } on EnrollmentException catch (error, stackTrace) {
      return left(EnrollmentException(
        message: 'Erro ao buscar matrículas: $error',
        stackTrace: stackTrace,
      ));
    } on Exception catch (error, stackTrace) {
      return left(EnrollmentException(
        message: 'Erro inesperado ao buscar matrículas: $error',
        stackTrace: stackTrace,
      ));
    }
  }

  @override
  Future<Either<IEnrollmentException, EnrollmentEntity>> create(
      EnrollmentDTO param) async {
    try {
      final result = await datasource.create(param);

      if (result is Map<String, dynamic>) {
        final enrollment = EnrollmentAdapter.fromMap(result);
        return right(enrollment);
      }
      return left(EnrollmentException(
        message: 'Falha ao registrar matrícula!',
        stackTrace: StackTrace.current,
      ));
    } on EnrollmentException catch (error, stackTrace) {
      return left(EnrollmentException(
        message: 'Erro ao criar matrícula: $error',
        stackTrace: stackTrace,
      ));
    } on Exception catch (error, stackTrace) {
      return left(EnrollmentException(
        message: 'Erro inesperado ao criar matrícula: $error',
        stackTrace: stackTrace,
      ));
    }
  }

  @override
  Future<Either<IEnrollmentException, EnrollmentEntity>> update(
      EnrollmentDTO param) async {
    try {
      final result = await datasource.update(param);

      if (result is Map<String, dynamic>) {
        final enrollment = EnrollmentAdapter.fromMap(result);
        return right(enrollment);
      }
      return left(EnrollmentException(
        message: 'Falha ao atualizar matrícula!',
        stackTrace: StackTrace.current,
      ));
    } on EnrollmentException catch (error, stackTrace) {
      return left(EnrollmentException(
        message: 'Erro ao atualizar matrícula: $error',
        stackTrace: stackTrace,
      ));
    } on Exception catch (error, stackTrace) {
      return left(EnrollmentException(
        message: 'Erro inesperado ao atualizar matrícula: $error',
        stackTrace: stackTrace,
      ));
    }
  }

  @override
  Future<Either<IEnrollmentException, EnrollmentEntity>> get(
      EnrollmentDTO param) async {
    try {
      final result = await datasource.get(param);

      if (result is Map<String, dynamic>) {
        return right(EnrollmentAdapter.fromMap(result));
      }
      return left(EnrollmentException(
        message: 'Matrícula não encontrada!',
        stackTrace: StackTrace.current,
      ));
    } on EnrollmentException catch (error, stackTrace) {
      return left(EnrollmentException(
        message: 'Erro ao buscar matrícula por ID: $error',
        stackTrace: stackTrace,
      ));
    } on Exception catch (error, stackTrace) {
      return left(EnrollmentException(
        message: 'Erro inesperado ao buscar matrícula por ID: $error',
        stackTrace: stackTrace,
      ));
    }
  }

  @override
  Future<Either<IEnrollmentException, bool>> delete(EnrollmentDTO param) async {
    try {
      final result = await datasource.delete(param);

      if (result is IEnrollmentException) {
        return left(EnrollmentException(
          message: 'Falha ao deletar matrícula!',
          stackTrace: StackTrace.current,
        ));
      }

      return right(true);
    } on EnrollmentException catch (error, stackTrace) {
      return left(EnrollmentException(
        message: 'Erro ao deletar matrícula: $error',
        stackTrace: stackTrace,
      ));
    } on Exception catch (error, stackTrace) {
      return left(EnrollmentException(
        message: 'Erro inesperado ao deletar matrícula: $error',
        stackTrace: stackTrace,
      ));
    }
  }
}
