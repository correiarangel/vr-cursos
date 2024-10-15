import 'package:flutter/cupertino.dart';

import '../../models/course_model.dart';

@immutable
abstract class CourseEvent {}

class CourseInitialEvent extends CourseEvent {}

class CreateCourseEvent extends CourseEvent {
  final CourseModel course;
  CreateCourseEvent(this.course);
}

class UpdateCourseEvent extends CourseEvent {
  final CourseModel course;
  UpdateCourseEvent(this.course);
}

class CurrentCourseEvent extends CourseEvent {
  final CourseModel course;
  CurrentCourseEvent(this.course);
}

class DeleteCourseEvent extends CourseEvent {
  final CourseModel course;
  DeleteCourseEvent(this.course);
}

class GetAllCourseEvent extends CourseEvent {}

class GetCourseEvent extends CourseEvent {
  final CourseModel studen;
  GetCourseEvent(this.studen);
}

class LoadingCourseEvent extends CourseEvent {}

class ChangedCourseInitalEvent extends CourseEvent {
  final CourseInitialEvent state;
  ChangedCourseInitalEvent({required this.state});
}
