import 'package:vr_curso_app/app/modules/course/domain/entities/cuorse_entity.dart';
import 'package:vr_curso_app/app/modules/student/domain/entities/student_entity.dart';

class EnrollmentEntity {
  final int id; 
  final StudentEntity student; 
  final CourseEntity course; 

  EnrollmentEntity({
    required this.id,
    required this.student,
    required this.course,
  });


}
