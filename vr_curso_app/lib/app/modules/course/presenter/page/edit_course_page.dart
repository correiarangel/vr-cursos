import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vr_curso_app/app/core/shared/widgets/vr_progress.dart';
import 'package:vr_curso_app/app/modules/course/presenter/blocs/event/course_event.dart';

import '../../../message_center/domain/enums/message_type.dart';
import '../blocs/course_bloc.dart';
import '../blocs/state/course_state.dart';
import '../models/course_model.dart';
import '../store/course_store.dart';
import '../widgets/vr_course_form.dart';

class EditCoursePage extends StatelessWidget {
  final CourseStore store;
  final CourseBloc bloc;
  final CourseModel course;
  const EditCoursePage({
    super.key,
    required this.store,
    required this.bloc,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CourseBloc>(
      create: (BuildContext context) => bloc,
      child: BodyCourse(
        course: course,
        store: store,
        bloc: bloc,
      ),
    );
  }
}

class BodyCourse extends StatefulWidget {
  final CourseStore store;
  final CourseBloc bloc;
  final CourseModel course;
  const BodyCourse(
      {super.key,
      required this.store,
      required this.bloc,
      required this.course});

  @override
  State<BodyCourse> createState() => _BodyCourseState();
}

class _BodyCourseState extends State<BodyCourse> {
  final keyFormCourse = GlobalKey<FormState>();

  bool isLoading = false;
  @override
  void initState() {
    widget.bloc.add(CurrentCourseEvent(widget.course));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Editar Curso'),
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
              BlocBuilder<CourseBloc, CourseState>(
                bloc: widget.bloc,
                builder: (context, state) {
                  if (state is CourseLoadingState) isLoading = true;

                  if (state is GetCourseSuccessState) {
                    isLoading = false;
                    widget.store.setCourse(state.course);
                  }

                  if (state is CurrentCourseState) {
                    widget.store.setCourse(state.course);
                    log('Acompanhando curso: ${state.course.description}');
                  }

                  if (state is UpdateCourseSuccessState) {
                    log('Curso Atualisado com sucesso!');
                    isLoading = false;
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.of(context).pop(true);
                    });
                  }

                  if (state is CourseExceptionState) {
                    log('ERRO --- ${state.exception.message}');
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
                      : VRCourseForm(
                          isUpdate: true,
                          course: widget.store.course,
                          store: widget.store,
                          bloc: widget.bloc,
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
