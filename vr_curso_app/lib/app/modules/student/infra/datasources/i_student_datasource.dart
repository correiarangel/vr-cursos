import '../../domain/student_dto/student_dto.dart';

abstract class IStudentDatasource {
  Future<dynamic> getAll();
  Future<dynamic> get(StudentDTO param);
  Future<dynamic> delete(StudentDTO param);
  Future<dynamic> update(StudentDTO param);
  Future<dynamic> create(StudentDTO param);
}
