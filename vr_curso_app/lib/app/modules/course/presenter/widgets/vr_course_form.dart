import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:vr_curso_app/app/modules/course/presenter/models/course_model.dart';
import 'package:vr_curso_app/app/modules/course/presenter/store/course_store.dart';
import 'package:vr_curso_app/app/modules/course/presenter/blocs/course_bloc.dart';

import 'vr_couse_description_form_field.dart';
import 'vr_couse_syllabus_form_field.dart'; // Ajuste o caminho conforme necessário

class VRCourseForm extends StatefulWidget {
  final CourseBloc bloc;
  final CourseStore store;
  final CourseModel course;
  final bool isUpdate;

  const VRCourseForm({
    super.key,
    required this.store,
    required this.bloc,
    required this.course,
    required this.isUpdate,
  });

  @override
  State<VRCourseForm> createState() => _VRCourseFormState();
}

class _VRCourseFormState extends State<VRCourseForm> {
  final keyFormCourse = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    log('description /////////// ${widget.course.description}');
    return Form(
      key: keyFormCourse,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.15),
          VRCourseDescriptionFormField(
            bloc: widget.bloc,
            input: CourseInputPage(
              course: widget.course,
              store: widget.store,
              textInputType: TextInputType.text,
              icon: Icons.book,
              validator: widget.store.validDescription,
            ),
          ),
          const SizedBox(height: 16),
          VRCourseSyllabusFormField(
            bloc: widget.bloc,
            input: CourseInputPage(
              course: widget.course,
              store: widget.store,
              textInputType: TextInputType.text,
              icon: Icons.book,
              validator: widget.store.validSyllabus,
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                if (keyFormCourse.currentState!.validate()) {
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
