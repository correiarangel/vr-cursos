// ignore_for_file: overridden_fields

import 'package:vr_curso_app/app/modules/course/presenter/models/course_model.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/params_dto/enrollment_dto.dart';
import 'package:vr_curso_app/app/modules/student/presenter/models/student_model.dart';

import '../../domain/entities/enrollment_entity.dart';

class EnrollmentModel extends EnrollmentEntity {

  @override
  final int id;
  @override
  final StudentModel student;
  @override
  final CourseModel course;
  
  EnrollmentModel(
      {required this.id, required this.student, required this.course})
      : super(id: id, student: StudentModel.fromEntity(student),course: CourseModel.fromModel( course));

  EnrollmentModel copyWith({
    int? id,
    StudentModel? student,
    CourseModel? course,
  }) {
    return EnrollmentModel(
      id: id ?? this.id,
      student: student ?? this.student,
      course: course ?? this.course,
    );
  }

  factory EnrollmentModel.empty() {
    return EnrollmentModel(
      id: -1,
      student: StudentModel(id: -1, name: '', enrollmentIds: []),
      course: CourseModel(
          id: -1, description: '', syllabus: '', enrollmentCodes: []),
    );
  }

  factory EnrollmentModel.fromModel(EnrollmentEntity entity) {
    return EnrollmentModel(
      id: entity.id,
      student:StudentModel.fromModel(entity.student) ,
      course:CourseModel.fromEntity( entity.course),
    );
  }

  static List<EnrollmentModel> fromListModel(List<EnrollmentEntity> entities) {
    return entities.map((entity) => EnrollmentModel.fromModel(entity)).toList();
  }

  static EnrollmentEntity fromEntity(EnrollmentModel model) {
    return EnrollmentEntity(
      id: model.id,
      student: model.student,
      course: model.course,
    );
  }

  static EnrollmentDTO fromDTO(EnrollmentModel model) {
    return EnrollmentDTO(entity: fromEntity(model));
  }

  @override
  String toString() =>
      'EnrollmentModel(id: $id, student: ${student.name}, course: ${course.description})';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EnrollmentModel &&
        other.id == id &&
        other.student == student &&
        other.course == course;
  }

  @override
  int get hashCode => id.hashCode ^ student.hashCode ^ course.hashCode;
}
