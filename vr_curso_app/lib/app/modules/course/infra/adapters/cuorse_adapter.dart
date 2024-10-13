
import 'package:vr_curso_app/app/modules/course/domain/entities/cuorse_entity.dart';

class CourseAdapter  {


static  Map<String, dynamic> toMap(CourseEntity entity) {
    return {
      'codigo':entity. id,
      'descricao':entity. description,
      'ementa': entity.syllabus,
      'cursoCodigosMatriculas': entity.enrollmentCodes,
    };
  }

  static CourseEntity fromMap(Map<String, dynamic> map) {
    return CourseEntity(
      id: map['codigo']?.toInt() ?? 0,
      description: map['descricao'] ?? '',
      syllabus: map['ementa'] ?? '',
      enrollmentCodes: List<int>.from(map['cursoCodigosMatriculas']??[]),
    );
  }

}
