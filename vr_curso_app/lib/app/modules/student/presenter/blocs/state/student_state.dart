import 'package:vr_curso_app/app/modules/student/exception/student_exception.dart';

import '../../models/student_model.dart';

abstract class StudentState {}

class StudentInitialState implements StudentState {}

class CreateStudentLoadingState implements StudentState {}

class StudentLoadingState implements StudentState {}

class CreateStudentSuccessState implements StudentState {
  final StudentModel student;
  CreateStudentSuccessState(this.student);
}

class DeleteStudentSuccessState implements StudentState {}

class UpdateStudentSuccessState implements StudentState {
  final StudentModel student;
  UpdateStudentSuccessState(this.student);
}

class GetAllStudentSuccessState implements StudentState {
  final List<StudentModel> students;
  GetAllStudentSuccessState(this.students);
}

class GetStudentSuccessState implements StudentState {
  final StudentModel student;
  GetStudentSuccessState(this.student);
}

class StudentExceptionState implements StudentState {
  final StudentException exception;
  StudentExceptionState(this.exception);
}
