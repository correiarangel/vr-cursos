import 'package:vr_curso_app/app/modules/course/presenter/blocs/course_bloc.dart';
import 'package:vr_curso_app/app/modules/course/presenter/blocs/event/course_event.dart';
import 'package:vr_curso_app/app/modules/message_center/presenter/store/message_store.dart';

import '../models/course_model.dart';

class CourseStore {
  final MessageStore message;

  CourseModel _course = CourseModel.empty();
  CourseModel get course => _course;
  void setCourse(CourseModel value) => _course = value;

  List<CourseModel> _courses = [];
  List<CourseModel> get courses => _courses;
  void setCourses(List<CourseModel> value) => _courses = value;

  CourseStore({required this.message});

  void create(
      {required String syllabus,
      required String description,
      required CourseBloc bloc}) {
    bloc.add(
      CreateCourseEvent(CourseModel(
        id: 0,
        description: description,
        syllabus: syllabus,
        enrollmentCodes: [],
      )),
    );
  }

  void update({required CourseModel course, required CourseBloc bloc}) {
    setCourse(course);
    bloc.add(UpdateCourseEvent(course));
  }

  void getAllCourses(CourseBloc bloc) {
    bloc.add(GetAllCourseEvent());
  }

  String? validDescription(String? value) {
    if (value == null || value.isEmpty) return 'Informe uma descrição!';
    return null;
  }

  String? validSyllabus(String? value) {
    if (value == null || value.isEmpty) return 'Informe uma amenta!';
    return null;
  }

  void onPressedForm({
    required bool isUpdate,
    required CourseBloc bloc,
  }) {
    if (isUpdate) {
      update(
        bloc: bloc,
        course: _course,
      );
    }
    if (!isUpdate) {
      create(
        bloc: bloc,
        syllabus: _course.syllabus,
        description: _course.description,
      );
    }
  }
}
