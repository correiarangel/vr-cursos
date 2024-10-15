import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:vr_curso_app/app/modules/enrollment/presenter/blocs/enrrollment_bloc.dart';
import 'package:vr_curso_app/app/modules/enrollment/presenter/models/enrollment_model.dart';
import 'package:vr_curso_app/app/modules/enrollment/presenter/store/enrollment_store.dart';
import 'package:vr_curso_app/app/modules/course/presenter/models/course_model.dart';
import 'package:vr_curso_app/app/modules/student/presenter/models/student_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vr_curso_app/app/modules/enrollment/presenter/blocs/enrrollment_bloc.dart';
import 'package:vr_curso_app/app/modules/enrollment/presenter/models/enrollment_model.dart';
import 'package:vr_curso_app/app/modules/enrollment/presenter/store/enrollment_store.dart';
import '../../../student/presenter/models/student_model.dart';
import '../../../course/presenter/models/course_model.dart';
import 'field_form_course_enrollment.dart'; // Certifique-se de que este caminho esteja correto
import 'field_form_student_enrollment.dart'; // Certifique-se de que este caminho esteja correto

class VREnrollmentForm extends StatefulWidget {
  final EnrollmentBloc bloc;
  final EnrollmentStore store;
  final EnrollmentModel enrollment;
  final List<StudentModel> listStudents;
  final List<CourseModel> listCourse;
  final bool isUpdate;

  const VREnrollmentForm({
    super.key,
    required this.store,
    required this.bloc,
    required this.enrollment,
    required this.isUpdate,
    required this.listStudents,
    required this.listCourse,
  });

  @override
  State<VREnrollmentForm> createState() => _VREnrollmentFormState();
}

class _VREnrollmentFormState extends State<VREnrollmentForm> {
  final keyFormEnrollment = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    widget.store.setStudentList(widget.listStudents);
    widget.store.setCourseList(widget.listCourse);

    // Se o enrollment for para atualização, defina os valores selecionados
    if (widget.isUpdate) {
      widget.store.setSelectedCourse(widget.enrollment.course);
      widget.store.setSelectedStudent(widget.enrollment.student);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Form(
      key: keyFormEnrollment,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.1),

          // Campo para selecionar Curso
          FieldFormCourseEnrollment(
            enrollmentBloc: widget.bloc,
            course: widget.store.selectedCourse??CourseModel.empty(),
            courses: widget.store.courseList,
          ),

          const SizedBox(height: 16),

          // Campo para selecionar Estudante
          FieldFormStudentEnrollment(
            enrollmentBloc: widget.bloc,
            student: widget.store.selectedStudent??StudentModel.empty(),
            students: widget.store.studentList,
          ),

          const SizedBox(height: 18),

          // Botão de salvar
          SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                if (keyFormEnrollment.currentState!.validate()) {
                  widget.store.onPressedForm(
                    isUpdate: widget.isUpdate,
                    bloc: widget.bloc,
                  );
                }
              },
              child: const Text('SALVAR'),
            ),
          ),
        ],
      ),
    );
  }
}


/* 
class VREnrollmentForm extends StatefulWidget {
  final EnrollmentBloc bloc;
  final EnrollmentStore store;
  final EnrollmentModel enrollment;
  final List<StudentModel> listStudents;
  final List<CourseModel> listCourse;
  final bool isUpdate;

  const VREnrollmentForm({
    super.key,
    required this.store,
    required this.bloc,
    required this.enrollment,
    required this.isUpdate,
    required this.listStudents,
    required this.listCourse,
  });

  @override
  State<VREnrollmentForm> createState() => _VREnrollmentFormState();
}

class _VREnrollmentFormState extends State<VREnrollmentForm> {
  final keyFormEnrollment = GlobalKey<FormState>();
  final List<StudentModel> _listStudents = [];
  final List<CourseModel> _listCourse = [];
  @override
  void initState() {
    super.initState();

    // Inicializa as listas de estudantes e cursos
    widget.store.getAllEnrollments(widget.bloc);
    widget.store.setStudentList(widget.listStudents);
    widget.store.setCourseList(widget.listCourse);
    widget.listStudents.removeWhere((std) => std.id == -1);
    for (var element in  widget.listStudents) {
         log('///////////////// 2 //////// ${element.id}');
    }
    widget.listCourse.removeWhere((course) => course.id == -1);
  for (var element in  widget.listCourse) {
         log('///////////////// 1 //////// ${element.id}');
    }
    if (widget.isUpdate) {
      widget.store.setSelectedCourse(widget.enrollment.course);
      widget.store.setSelectedStudent(widget.enrollment.student);
    }

    log('///////////////// 1//////// ${widget.listCourse.length}');
    log('//////////////// 2/////////// ${widget.listStudents.length}');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Form(
      key: keyFormEnrollment,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.1),

          // Dropdown para selecionar Curso
          widget.listCourse.isEmpty
              ? Text('Não há corsos')
              : DropdownButtonFormField<CourseModel>(
                  value: widget.store.selectedCourse,
                  decoration: const InputDecoration(
                    labelText: 'Selecionar Curso',
                    border: OutlineInputBorder(),
                  ),
                  items: widget.listCourse.map((CourseModel course) {
                    return DropdownMenuItem<CourseModel>(
                      value: course,
                      child: Text(course.description),
                    );
                  }).toList(), // Caso não haja cursos
                  onChanged: (CourseModel? value) {
                    widget.store.setSelectedCourse(value);
                  },
                  validator: (value) =>
                      value == null ? 'Selecione um curso' : null,
                ),

          const SizedBox(height: 16),

          // Dropdown para selecionar Estudante
          widget.listStudents.isEmpty
              ? Text('Não há alunos')
              : DropdownButtonFormField<StudentModel>(
                  value: widget.store.selectedStudent,
                  decoration: const InputDecoration(
                    labelText: 'Selecionar Estudante',
                    border: OutlineInputBorder(),
                  ),
                  items: widget.listStudents.map((StudentModel student) {
                    return DropdownMenuItem<StudentModel>(
                      value: student,
                      child: Text(student.name),
                    );
                  }).toList(),
                  // Caso não haja estudantes
                  onChanged: (StudentModel? value) {
                    widget.store.setSelectedStudent(value);
                  },
                  validator: (value) =>
                      value == null ? 'Selecione um estudante' : null,
                ),

          const SizedBox(height: 18),

          // Botão de salvar
          SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                if (keyFormEnrollment.currentState!.validate()) {
                  widget.store.onPressedForm(
                    isUpdate: widget.isUpdate,
                    bloc: widget.bloc,
                  );
                }
              },
              child: const Text('SALVAR'),
            ),
          ),
        ],
      ),
    );
  }
}
  */

/* import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vr_curso_app/app/modules/enrollment/presenter/models/enrollment_model.dart';
import 'package:vr_curso_app/app/modules/enrollment/presenter/store/enrollment_store.dart';
import 'package:vr_curso_app/app/modules/course/presenter/models/course_model.dart';
import 'package:vr_curso_app/app/modules/student/presenter/models/student_model.dart';
import '../blocs/enrrollment_bloc.dart';

class VREnrollmentForm extends StatefulWidget {
  final EnrollmentBloc bloc;
  final EnrollmentStore store;
  final EnrollmentModel enrollment;
  final List<StudentModel> listStudents;
  final List<CourseModel> listCourse;
  final bool isUpdate;

  const VREnrollmentForm({
    super.key,
    required this.store,
    required this.bloc,
    required this.enrollment,
    required this.isUpdate,
    required this.listStudents,
    required this.listCourse,
  });

  @override
  State<VREnrollmentForm> createState() => _VREnrollmentFormState();
}

class _VREnrollmentFormState extends State<VREnrollmentForm> {
  final keyFormEnrollment = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    widget.store.getAllEnrollments(widget.bloc);

    widget.store.setStudentList(widget.listStudents);
    widget.store.setCourseList(widget.listCourse);
    log('///////////////// 1//////// ${widget.listCourse.length}');
    log('//////////////// 2/////////// ${widget.listStudents.length}');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Form(
      key: keyFormEnrollment,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.1),

          // Dropdown para selecionar Curso
          DropdownButtonFormField<CourseModel>(
            value: widget.store.selectedCourse,
            decoration: const InputDecoration(
              labelText: 'Selecionar Curso',
              border: OutlineInputBorder(),
            ),
            items: widget.listCourse.map((CourseModel course) {
              return DropdownMenuItem<CourseModel>(
                value: course,
                child: Text(course.description),
              );
            }).toList(),
            onChanged: (CourseModel? value) {
             
                widget.store.setSelectedCourse(value);
             
            },
            validator: (value) => value == null ? 'Selecione um curso' : null,
          ),

          const SizedBox(height: 16),

          // Dropdown para selecionar Estudante
          DropdownButtonFormField<StudentModel>(
            value: widget.store.selectedStudent,
            decoration: const InputDecoration(
              labelText: 'Selecionar Estudante',
              border: OutlineInputBorder(),
            ),
            items: widget.listStudents.map((StudentModel student) {
              return DropdownMenuItem<StudentModel>(
                value: student,
                child: Text(student.name),
              );
            }).toList(),
            onChanged: (StudentModel? value) {
              
                widget.store.setSelectedStudent(value);
             
            },
            validator: (value) =>
                value == null ? 'Selecione um estudante' : null,
          ),

          const SizedBox(height: 18),

          // Botão de salvar
          SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                if (keyFormEnrollment.currentState!.validate()) {
                  widget.store.onPressedForm(
                    isUpdate: widget.isUpdate,
                    bloc: widget.bloc,
                  );
                }
              },
              child: const Text('SALVAR'),
            ),
          ),
        ],
      ),
    );
  }
}

 */


/* import 'package:flutter/material.dart';
import 'package:vr_curso_app/app/modules/enrollment/presenter/models/enrollment_model.dart';
import 'package:vr_curso_app/app/modules/enrollment/presenter/store/enrollment_store.dart';

import 'package:vr_curso_app/app/modules/course/presenter/models/course_model.dart';
import 'package:vr_curso_app/app/modules/student/presenter/models/student_model.dart';

import '../blocs/enrrollment_bloc.dart';

class VREnrollmentForm extends StatefulWidget {
  final EnrollmentBloc bloc;
  final EnrollmentStore store;
  final EnrollmentModel enrollment;
  final bool isUpdate;

  const VREnrollmentForm({
    super.key,
    required this.store,
    required this.bloc,
    required this.enrollment,
    required this.isUpdate,
  });

  @override
  State<VREnrollmentForm> createState() => _VREnrollmentFormState();
}

class _VREnrollmentFormState extends State<VREnrollmentForm> {
  final keyFormEnrollment = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    courseList = widget.store.courseList; // Carregar a lista de cursos
    studentList = widget.store.studentList; // Carregar a lista de estudantes
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Form(
      key: keyFormEnrollment,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.1),
          
          // Select Form Field para Curso
          DropdownButtonFormField<CourseModel>(
            value: selectedCourse,
            decoration: const InputDecoration(
              labelText: 'Selecionar Curso',
              border: OutlineInputBorder(),
            ),
            items: courseList.map((CourseModel course) {
              return DropdownMenuItem<CourseModel>(
                value: course,
                child: Text(course.description),
              );
            }).toList(),
            onChanged: (CourseModel? value) {
              setState(() {
                selectedCourse = value;
                widget.store. setCourse(value);
              });
            },
            validator: (value) => value == null ? 'Selecione um curso' : null,
          ),
          
          const SizedBox(height: 16),
          
          // Select Form Field para Estudante
          DropdownButtonFormField<StudentModel>(
            value: selectedStudent,
            decoration: const InputDecoration(
              labelText: 'Selecionar Estudante',
              border: OutlineInputBorder(),
            ),
            items: studentList.map((StudentModel student) {
              return DropdownMenuItem<StudentModel>(
                value: student,
                child: Text(student.name),
              );
            }).toList(),
            onChanged: (StudentModel? value) {
              setState(() {
                selectedStudent = value;
                widget.store.setStudent(value);
              });
            },
            validator: (value) => value == null ? 'Selecione um estudante' : null,
          ),
          
          const SizedBox(height: 18),
          
          // Botão de salvar
          SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                if (keyFormEnrollment.currentState!.validate()) {
                  widget.store.onPressedForm(
                    isUpdate: widget.isUpdate,
                    bloc: widget.bloc,
                  );
                }
              },
              child: const Text('SALVAR'),
            ),
          ),
        ],
      ),
    );
  }
}
 */