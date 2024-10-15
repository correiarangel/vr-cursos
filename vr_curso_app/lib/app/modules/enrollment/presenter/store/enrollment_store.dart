import 'package:flutter/cupertino.dart';
import 'package:vr_curso_app/app/modules/student/presenter/models/student_model.dart';

import '../../../course/presenter/models/course_model.dart';
import '../../../message_center/presenter/store/message_store.dart';
import '../blocs/enrrollment_bloc.dart';
import '../blocs/event/enrrollment_event.dart';
import '../models/enrollment_model.dart';

class EnrollmentStore extends ChangeNotifier {
  final MessageStore message;

  EnrollmentStore({required this.message});

  EnrollmentModel _enrollment = EnrollmentModel.empty();
  EnrollmentModel get enrollment => _enrollment;
  void setEnrollment(EnrollmentModel value) {
    _enrollment = value;
    notifyListeners();
  }

  List<EnrollmentModel> _enrollments = [];
  List<EnrollmentModel> get enrollments => _enrollments;
  void setEnrollments(List<EnrollmentModel> value) {
    _enrollments = value;
    notifyListeners();
  }

  List<CourseModel> _courseList = [];
  List<CourseModel> get courseList => _courseList;
  void setCourseList(List<CourseModel> courses) {
    _courseList = courses;
    notifyListeners();
  }

  List<StudentModel> _studentList = [];
  List<StudentModel> get studentList => _studentList;

  void setStudentList(List<StudentModel> students) {
    _studentList = students;
    notifyListeners();
  }

  CourseModel? _selectedCourse = CourseModel.empty();
  CourseModel? get selectedCourse => _selectedCourse;

  void setSelectedCourse(CourseModel? course) {
    _selectedCourse = course;
    notifyListeners();
  }

  StudentModel? _selectedStudent = StudentModel.empty();
  StudentModel? get selectedStudent => _selectedStudent;

  void setSelectedStudent(StudentModel? student) {
    _selectedStudent = student;
    notifyListeners();
  }

  // Método para criar uma nova matrícula
  void create({
    required EnrollmentModel enrollment,
    required EnrollmentBloc bloc,
  }) {
    bloc.add(
      CreateEnrollmentEvent(EnrollmentModel(
        id: 0,
        course: enrollment.course,
        student: enrollment.student,
      )),
    );
  }

  void update(
      {required EnrollmentModel enrollment, required EnrollmentBloc bloc}) {
    // setEnrollment(enrollment);
    bloc.add(UpdateEnrollmentEvent(enrollment));
  }

  void getAllEnrollments(EnrollmentBloc bloc) {
    bloc.add(GetAllEnrollmentEvent());
  }

  String? validStudentName(String? value) {
    if (value == null || value.isEmpty) return 'Informe o estudante!';
    return null;
  }

  // Validação para o código do curso
  String? validCourseDescrition(String? value) {
    if (value == null || value.isEmpty) return 'Informe o curso!';
    return null;
  }

  // Ação a ser executada ao submeter o formulário de matrícula
  void onPressedForm({
    required bool isUpdate,
    required EnrollmentBloc bloc,
  }) {
    if (isUpdate) {
      update(
        bloc: bloc,
        enrollment: _enrollment,
      );
    }
    if (!isUpdate) {
      create(bloc: bloc, enrollment: _enrollment);
    }
  }
}
