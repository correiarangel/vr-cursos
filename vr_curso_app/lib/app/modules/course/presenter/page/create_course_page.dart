import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vr_curso_app/app/core/shared/widgets/vr_progress.dart';

import '../../../message_center/domain/enums/message_type.dart';
import '../blocs/course_bloc.dart';
import '../blocs/state/course_state.dart';
import '../store/course_store.dart';
import '../widgets/vr_course_form.dart';

class CreateCoursePage extends StatelessWidget {
  final CourseStore store;
  final CourseBloc bloc;

  const CreateCoursePage({super.key, required this.store, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CourseBloc>(
      create: (BuildContext context) => bloc,
      child: BodyCourse(
        store: store,
        bloc: bloc,
      ),
    );
  }
}

class BodyCourse extends StatefulWidget {
  final CourseStore store;
  final CourseBloc bloc;

  const BodyCourse({super.key, required this.store, required this.bloc});

  @override
  State<BodyCourse> createState() => _BodyCourseState();
}

class _BodyCourseState extends State<BodyCourse> {
  final keyFormCourse = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cadastrar Curso'),
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
                  if (state is CreateCourseLoadingState) isLoading = true;

                  if (state is GetCourseSuccessState) {
                    isLoading = false;
                    widget.store.setCourse(state.course);
                  }

                  if (state is CurrentCourseState) {
                    widget.store.setCourse(state.course);
                  }
                  if (state is CreateCourseSuccessState) {
                    isLoading = false;
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      widget.store.message.creatMessage(
                        message: 'Curso cadastrado com sucesso!',
                        color: colorScheme,
                        icon: Icons.check,
                        type: MessageType.success,
                      );
                    });
                  }

                  if (state is CourseExceptionState) {
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
                          isUpdate: false,
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
