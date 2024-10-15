import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vr_curso_app/app/core/shared/widgets/vr_progress.dart';
import 'package:vr_curso_app/app/modules/course/presenter/blocs/event/course_event.dart';
import 'package:vr_curso_app/app/modules/course/presenter/blocs/state/course_state.dart';
import 'package:vr_curso_app/app/modules/course/presenter/models/course_model.dart';
import 'package:vr_curso_app/app/modules/student/presenter/blocs/event/student_event.dart';
import 'package:vr_curso_app/app/modules/student/presenter/models/student_model.dart';

import '../../../message_center/domain/enums/message_type.dart';

import '../../../student/presenter/blocs/state/student_state.dart';
import '../blocs/enrrollment_bloc.dart';
import '../blocs/state/enrrollment_state.dart';
import '../store/enrollment_store.dart';
import '../widgets/vr_enrollment_form.dart';

class CreateEnrollmentPage extends StatelessWidget {
  final EnrollmentStore store;
  final EnrollmentBloc bloc;

  const CreateEnrollmentPage(
      {super.key, required this.store, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EnrollmentBloc>(
      create: (BuildContext context) => bloc,
      child: BodyEnrollment(
        store: store,
        bloc: bloc,
      ),
    );
  }
}

class BodyEnrollment extends StatefulWidget {
  final EnrollmentStore store;
  final EnrollmentBloc bloc;

  const BodyEnrollment({super.key, required this.store, required this.bloc});

  @override
  State<BodyEnrollment> createState() => _BodyEnrollmentState();
}

class _BodyEnrollmentState extends State<BodyEnrollment> {
  final keyFormEnrollment = GlobalKey<FormState>();

  bool isLoading = false;

  List<StudentModel> listStudents = [];
  List<CourseModel> listCourse = [];
  late StreamSubscription subStudents;
  late StreamSubscription subCourse;
  bool loading = false;
  @override
  void initState() {
    subStudents = widget.bloc.studentBloc.stream.listen((event) {
      if (mounted) setState(() {});
    });
    subCourse = widget.bloc.courseBloc.stream.listen((event) {
      if (mounted) setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.bloc.studentBloc.add(GetAllStudentEvent());
      widget.bloc.courseBloc.add(GetAllCourseEvent());
    });
    super.initState();
  }

  @override
  void dispose() {
    subCourse.cancel();
    subStudents.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;

    final stateCourse = widget.bloc.courseBloc.state;
    final stateStudent = widget.bloc.studentBloc.state;
    if (stateStudent is GetAllStudentSuccessState) {
      listStudents = stateStudent.students;
      loading = false;
    }
    if (stateStudent is StudentLoadingState) loading = true;
    if (stateStudent is StudentExceptionState) loading = false;

    if (stateCourse is GetAllCourseSuccessState) {
      listCourse = stateCourse.courses;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cadastrar Matrícula'),
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BlocBuilder<EnrollmentBloc, EnrollmentState>(
                bloc: widget.bloc,
                builder: (context, state) {
                  if (state is CreateEnrollmentLoadingState) isLoading = true;

                  if (state is GetEnrollmentSuccessState) {
                    isLoading = false;
                    widget.store.setEnrollment(state.enrollment);
                  }

                  if (state is CurrentEnrollmentState) {
                    widget.store.setEnrollment(state.enrollment);
                  }
                  if (state is CreateEnrollmentSuccessState) {
                    isLoading = false;
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      widget.store.message.creatMessage(
                        message: 'Matrícula cadastrada com sucesso!',
                        color: colorScheme,
                        icon: Icons.check,
                        type: MessageType.success,
                      );
                    });
                  }

                  if (state is EnrollmentExceptionState) {
                    isLoading = false;
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      widget.store.message.creatMessage(
                        message: state.exception.message,
                        color: colorScheme,
                        icon: Icons.error,
                        type: MessageType.error,
                      );
                    });
                  }

                  return isLoading
                      ? VRProgress(height: size.height * 0.3)
                      : VREnrollmentForm(
                          isUpdate: false,
                          enrollment: widget.store.enrollment,
                          store: widget.store,
                          bloc: widget.bloc,
                          listStudents: listStudents,
                          listCourse: listCourse,
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
