import 'package:flutter/foundation.dart';

import '../../domain/cuorso_dto/cuorso_dto.dart';
import '../../domain/entities/cuorse_entity.dart';

class CourseModel extends CourseEntity {
  CourseModel({
    required super.id,
    required super.description,
    required super.syllabus,
    required super.enrollmentCodes,
  });

  CourseModel copyWith({
    int? id,
    String? description,
    String? syllabus,
    List<int>? enrollmentCodes,
  }) {
    return CourseModel(
      id: id ?? this.id,
      description: description ?? this.description,
      syllabus: syllabus ?? this.syllabus,
      enrollmentCodes: enrollmentCodes ?? this.enrollmentCodes,
    );
  }

  factory CourseModel.empty() {
    return CourseModel(
      id: -1,
      description: '',
      syllabus: '',
      enrollmentCodes: [],
    );
  }

  factory CourseModel.fromEntity(CourseEntity entity) {
    return CourseModel(
      id: entity.id,
      description: entity.description,
      syllabus: entity.syllabus,
      enrollmentCodes: entity.enrollmentCodes,
    );
  }

  static List<CourseModel> fromListEntity(List<CourseEntity> entities) {
    return entities.map((entity) => CourseModel.fromEntity(entity)).toList();
  }

  static CourseEntity fromModel(CourseModel model) {
    return CourseEntity(
      id: model.id,
      description: model.description,
      syllabus: model.syllabus,
      enrollmentCodes: model.enrollmentCodes,
    );
  }

  static CourseDTO fromDTO(CourseModel model) {
    return CourseDTO(fromModel(model));
  }

  @override
  String toString() =>
      'CourseModel(id: $id, description: $description, syllabus: $syllabus, enrollmentCodes: $enrollmentCodes)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CourseModel &&
        other.id == id &&
        other.description == description &&
        other.syllabus == syllabus &&
        listEquals(other.enrollmentCodes, enrollmentCodes);
  }

  @override
  int get hashCode =>
      id.hashCode ^ description.hashCode ^ syllabus.hashCode ^ enrollmentCodes.hashCode;
}
