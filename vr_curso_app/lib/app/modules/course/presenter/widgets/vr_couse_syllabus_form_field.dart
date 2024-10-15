import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vr_curso_app/app/core/shared/widgets/vr_input_decuration.dart';

import 'package:vr_curso_app/app/modules/course/presenter/models/course_model.dart';
import 'package:vr_curso_app/app/modules/course/presenter/blocs/course_bloc.dart';

import '../blocs/event/course_event.dart';
import '../blocs/state/course_state.dart';
import 'vr_couse_description_form_field.dart';

class VRCourseSyllabusFormField extends StatefulWidget {
  final CourseInputPage input;
  final CourseBloc bloc;

  const VRCourseSyllabusFormField({
    super.key,
    required this.input,
    required this.bloc,
  });

  @override
  State<VRCourseSyllabusFormField> createState() =>
      _VRCourseSyllabusFormFieldState();
}

class _VRCourseSyllabusFormFieldState extends State<VRCourseSyllabusFormField> {
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
          log('Acompanhando o syllabus do curso: ${course.syllabus}');
        }
      },
      child: TextFormField(
        key: const Key('FieldCourseSyllabus'),
        controller: controller,
        textCapitalization: TextCapitalization.sentences,
        onChanged: onChanged,
        validator: widget.input.store.validSyllabus,
        maxLength: 50,
        decoration: VRInputDecoration.decoration(
          context: context,
          labelText: 'Ementa do Curso',
          hintText: 'Digite a ementa do curso...',
        ),
      ),
    );
  }

  void onChanged(String value) {
    course = course.copyWith(syllabus: value);
    widget.bloc.add(CurrentCourseEvent(course));
  }

  void _initText(CourseModel course) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.text = course.syllabus;
    });
  }
}
