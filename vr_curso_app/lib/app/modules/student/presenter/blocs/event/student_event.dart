import 'package:flutter/cupertino.dart';
import 'package:vr_curso_app/app/modules/student/presenter/models/student_model.dart';

@immutable
abstract class StudentEvent {}

class StudentInitialEvent extends StudentEvent {}

class CreateStudentEvent extends StudentEvent {
  final StudentModel student;
  CreateStudentEvent(this.student);
}

class UpdateStudentEvent extends StudentEvent {
  final StudentModel student;
  UpdateStudentEvent(this.student);
}
class DeleteStudentEvent extends StudentEvent {
  final StudentModel student;
  DeleteStudentEvent(this.student);
}
class GetAllStudentEvent extends StudentEvent {}

class GetStudentEvent extends StudentEvent {
  final StudentModel studen;
  GetStudentEvent(this.studen);
}

class LoadingStudentEvent extends StudentEvent {}

class ChangedStudentInitalEvent extends StudentEvent {
  final StudentInitialEvent state;
  ChangedStudentInitalEvent({required this.state});
}
