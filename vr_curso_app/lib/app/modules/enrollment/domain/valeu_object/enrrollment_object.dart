import 'package:vr_curso_app/app/modules/enrollment/domain/entities/enrollment_entity.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/params_dto/enrollment_dto.dart';

class EnrollmentObject {
  static bool valid(EnrollmentDTO param) {
    if (param.entity.student.id >= 0 && param.entity.course.id >= 0) {
      return true;
    }
    return false;
  }

  static bool isStudentEnrolledInCourse({
    required EnrollmentDTO param,
    required List<EnrollmentEntity> entities,
  }) {
    final studentToCheck = param.entity.student;
    final courseToCheck = param.entity.course;

    for (final enrollment in entities) {
      if (enrollment.student.id == studentToCheck.id &&
          enrollment.course.id == courseToCheck.id) {
        return true;
      }
    }
    return false;
  }
}
