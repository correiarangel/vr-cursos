import 'dart:developer';

import 'package:vr_curso_app/app/modules/message_center/presenter/store/message_store.dart';
import 'package:vr_curso_app/app/modules/student/presenter/blocs/event/student_event.dart';
import 'package:vr_curso_app/app/modules/student/presenter/blocs/student_bloc.dart';
import 'package:vr_curso_app/app/modules/student/presenter/models/student_model.dart';

class StudentStore {
  final MessageStore message;

  StudentModel _student = StudentModel.empty();
  StudentModel get student => _student;
  void setStudent(StudentModel value) => _student = value;

  List<StudentModel> _students = [];
  List<StudentModel> get students => _students;
  void setStudents(List<StudentModel> value) => _students = value;

  StudentStore({required this.message});

  void create({required String name, required StudentBloc bloc}) {
    log('Deve salvar........$name ....');
    bloc.add(
      CreateStudentEvent(StudentModel(id: 0, name: name, enrollmentIds: [])),
    );
  }

  void update({required StudentModel student, required StudentBloc bloc}) {
    setStudent(student);
    bloc.add(UpdateStudentEvent(student));
  }

  void getAllStudents(StudentBloc bloc) {
    bloc.add(GetAllStudentEvent());
  }

  String? validName(String? value) {
    if (value == null || value.isEmpty) return 'Infrome um nome!';
    return null;
  }

  void onPressedForm({
    required bool isUpdate,
    required StudentBloc bloc,
  }) {
    if (isUpdate) {
      update(
        bloc: bloc,
        student: _student,
      );
    }
    if (!isUpdate) {
      create(
        bloc: bloc,
        name: student.name,
      );
    }
  }
}
