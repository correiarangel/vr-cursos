import 'package:flutter_test/flutter_test.dart';
import 'package:vr_curso_app/app/modules/course/domain/entities/cuorse_entity.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/entities/enrollment_entity.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/params_dto/enrollment_dto.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/valeu_object/enrrollment_object.dart';
import 'package:vr_curso_app/app/modules/student/domain/entities/student_entity.dart';


void main() {
  group('EnrollmentObject.valid', () {
    test('Should return true when student and course IDs are greater than or equal to 0', () {
      // Arrange: Defina um EnrollmentDTO válido
      final student = StudentEntity(id: 1, name: 'John Doe', enrollmentIds: []);
      const course = CourseEntity(id: 1, syllabus: 'Math', description: 'desc', enrollmentCodes: []);
      final enrollmentEntity = EnrollmentEntity(id: 1, student: student, course: course);
      final enrollmentDTO = EnrollmentDTO(entity: enrollmentEntity);

      // Act: Chame o método estático valid
      final isValid = EnrollmentObject.valid(enrollmentDTO);

      // Assert: Verifique se o resultado é true
      expect(isValid, true);
    });

    test('Should return false when student ID is less than 0', () {

      final student = StudentEntity(id: -1, name: 'John Doe', enrollmentIds: []);
      const course = CourseEntity(id: 1, syllabus: 'Math', description: 'desc', enrollmentCodes: []);
      final enrollmentEntity = EnrollmentEntity(id: 1, student: student, course: course);
      final enrollmentDTO = EnrollmentDTO(entity: enrollmentEntity);


      final isValid = EnrollmentObject.valid(enrollmentDTO);


      expect(isValid, false);
    });

    test('Should return false when course ID is less than 0', () {

      final student = StudentEntity(id: 1, name: 'John Doe', enrollmentIds: []);
      const course = CourseEntity(id: -1, syllabus: 'Math', description: 'desc', enrollmentCodes: []);
      final enrollmentEntity = EnrollmentEntity(id: 1, student: student, course: course);
      final enrollmentDTO = EnrollmentDTO(entity: enrollmentEntity);


      final isValid = EnrollmentObject.valid(enrollmentDTO);

  
      expect(isValid, false);
    });

    test('Should return false when both student and course IDs are less than 0', () {
      // Arrange:
      final student = StudentEntity(id: -1, name: 'John Doe', enrollmentIds: []);
      const course = CourseEntity(id: -1, syllabus: 'Math', description: 'desc', enrollmentCodes: []);
      final enrollmentEntity = EnrollmentEntity(id: 1, student: student, course: course);
      final enrollmentDTO = EnrollmentDTO(entity: enrollmentEntity);

      // Act: 
      final isValid = EnrollmentObject.valid(enrollmentDTO);

      // Assert:
      expect(isValid, false);
    });
  });
}
