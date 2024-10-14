import "package:vr_curso_app/app/modules/enrollment/domain/params_dto/enrollment_dto.dart";

abstract class IEnrollmentDatasource {
  Future<dynamic> getAll();
  Future<dynamic> get(EnrollmentDTO param);
  Future<dynamic> delete(EnrollmentDTO param);
  Future<dynamic> update(EnrollmentDTO param);
  Future<dynamic> create(EnrollmentDTO param);
}
