import 'package:vr_curso_app/app/modules/course/exception/course_exception.dart';
import 'package:vr_curso_app/app/modules/student/exception/student_exception.dart';

import '../../models/course_model.dart';



abstract class CourseState {}

class CourseInitialState implements CourseState {}

class CreateCourseLoadingState implements CourseState {}

class CourseLoadingState implements CourseState {}

class CreateCourseSuccessState implements CourseState {
  final CourseModel course;
  CreateCourseSuccessState(this.course);
}
class CurrentCourseState implements CourseState {
  final CourseModel course;
  CurrentCourseState(this.course);
}
class DeleteCourseSuccessState implements CourseState {}

class UpdateCourseSuccessState implements CourseState {
  final CourseModel course;
  UpdateCourseSuccessState(this.course);
}

class GetAllCourseSuccessState implements CourseState {
  final List<CourseModel> courses;
  GetAllCourseSuccessState(this.courses);
}

class GetCourseSuccessState implements CourseState {
  final CourseModel course;
  GetCourseSuccessState(this.course);
}

class CourseExceptionState implements CourseState {
  final CourseException exception;
  CourseExceptionState(this.exception);
}