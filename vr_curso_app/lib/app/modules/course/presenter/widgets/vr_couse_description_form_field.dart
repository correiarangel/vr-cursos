import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vr_curso_app/app/modules/course/presenter/models/course_model.dart';
import 'package:vr_curso_app/app/modules/course/presenter/blocs/course_bloc.dart';
import 'package:vr_curso_app/app/modules/course/presenter/store/course_store.dart';

import '../../../../core/shared/widgets/vr_input_decuration.dart';
import '../blocs/event/course_event.dart';
import '../blocs/state/course_state.dart';

class VRCourseDescriptionFormField extends StatefulWidget {
  final CourseInputPage input;
  final CourseBloc bloc;

  const VRCourseDescriptionFormField({
    super.key,
    required this.input,
    required this.bloc,
  });

  @override
  State<VRCourseDescriptionFormField> createState() =>
      _VRCourseDescriptionFormFieldState();
}

class _VRCourseDescriptionFormFieldState
    extends State<VRCourseDescriptionFormField> {
  final TextEditingController controller = TextEditingController();

  CourseModel course = CourseModel.empty();

  @override
  void initState() {
    super.initState();
      _initText(widget.input.course);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CourseBloc, CourseState>(
      bloc: widget.bloc,
      listener: (context, state) {
        if (state is CurrentCourseState) {
          course = state.course;
          _initText(course);
          log('Acompanhando o nome do curso: ${course.description}');
        }
      },
      child: TextFormField(
        key: const Key('FieldCourse'),
        controller: controller,
        textCapitalization: TextCapitalization.words,
        onChanged: onChanged,
        validator: widget.input.store.validDescription,
        maxLength: 50,
        decoration:VRInputDecoration.decoration(
          context: context,
          labelText: 'Nome do Curso',
          hintText: 'Digite o nome do curso...',
          // Você pode adicionar um ícone ou outros elementos decorativos conforme necessário
        ),
      ),
    );
  }

  void onChanged(String value) {
    course = course.copyWith(description: value);
    widget.bloc.add(CurrentCourseEvent(course));
  }

  void _initText(CourseModel course) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.text = course.description;
    });
  }
}

class CourseInputPage {
  final CourseStore store;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final IconData icon;
  final CourseModel course;

  CourseInputPage({
    required this.store,
    required this.textInputType,
    required this.validator,
    required this.icon,
    required this.course,
  });
}
