import 'package:vr_curso_app/app/modules/course/infra/adapters/cuorse_adapter.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/entities/enrollment_entity.dart';
import 'package:vr_curso_app/app/modules/student/infra/adapters/student_adapter.dart';

class EnrollmentAdapter {
  static Map<String, dynamic> toMap(EnrollmentEntity entity) {
    return {
      'codigo': entity.id,
      'aluno': StudentAdapter.toMap(entity.student),
      'curso': CourseAdapter.toMap(entity.course),
    };
  }

  static EnrollmentEntity fromMap(Map<String, dynamic> map) {
    return EnrollmentEntity(
      id: map['codigo']?.toInt() ?? 0,
      student: StudentAdapter.fromMap(map['aluno']),
      course: CourseAdapter.fromMap(map['curso']),
    );
  }
}
