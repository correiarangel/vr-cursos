import 'dart:convert';

import 'package:vr_curso_app/app/modules/student/domain/entities/student_entity.dart';

class StudentAdapter {
  static Map<String, dynamic> toMap(StudentEntity entity) {
    return {
      'codigo': entity.id,
      'name': entity.name,
      'alunoCodigosMatriculas': entity.enrollmentIds,
    };
  }

  static StudentEntity fromMap(Map<String, dynamic> map) {
    return StudentEntity(
      id: map['codigo']?.toInt() ?? 0,
      name: map['nome'] ?? '',
      enrollmentIds: List<int>.from(map['alunoCodigosMatriculas']),
    );
  }

    String toJson(StudentEntity entity) => json.encode(toMap(entity));

  static StudentEntity fromJson(String source) => fromMap(json.decode(source));
}
