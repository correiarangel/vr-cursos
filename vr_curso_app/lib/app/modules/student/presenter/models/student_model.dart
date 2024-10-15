import 'package:flutter/foundation.dart';

import 'package:vr_curso_app/app/modules/student/domain/entities/student_entity.dart';
import 'package:vr_curso_app/app/modules/student/domain/student_dto/student_dto.dart';

class StudentModel extends StudentEntity {
  StudentModel(
      {required super.id, required super.name, required super.enrollmentIds});

  StudentModel copyWith({
    int? id,
    String? name,
    List<int>? enrollmentIds,
  }) {
    return StudentModel(
      id: id ?? this.id,
      name: name ?? this.name,
      enrollmentIds: enrollmentIds ?? this.enrollmentIds,
    );
  }
  factory StudentModel.empty() {
    return StudentModel(
      id: -1,
      name: '',
      enrollmentIds: [],
    );
  }
  factory StudentModel.fromModel(StudentEntity entity) {
    return StudentModel(
      id: entity.id,
      name: entity.name,
      enrollmentIds: entity.enrollmentIds,
    );
  }
  static List<StudentModel> fromListModel(List<StudentEntity> entitys) {
    return entitys.map((entity) => StudentModel.fromModel(entity)).toList();
  }

  static StudentEntity fromEntity(StudentModel model) {
    return StudentEntity(
        id: model.id, name: model.name, enrollmentIds: model.enrollmentIds);
  }

  static StudentDTO fromDTO(StudentModel model) {
    return StudentDTO(entity: fromEntity(model));
  }

  @override
  String toString() =>
      'StudentModel(id: $id, name: $name, enrollmentIds: $enrollmentIds)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StudentModel &&
        other.id == id &&
        other.name == name &&
        listEquals(other.enrollmentIds, enrollmentIds);
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ enrollmentIds.hashCode;
}
