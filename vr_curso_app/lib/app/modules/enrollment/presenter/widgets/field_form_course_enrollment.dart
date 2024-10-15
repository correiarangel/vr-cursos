import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vr_curso_app/app/core/shared/widgets/vr_app_search_select.dart';
import 'package:vr_curso_app/app/core/shared/widgets/vr_input_decuration.dart';

import 'package:vr_curso_app/app/modules/enrollment/presenter/blocs/enrrollment_bloc.dart';
import 'package:vr_curso_app/app/modules/enrollment/presenter/blocs/event/enrrollment_event.dart';
import 'package:vr_curso_app/app/modules/enrollment/presenter/models/enrollment_model.dart';

import '../blocs/state/enrrollment_state.dart';

import '../../../course/presenter/models/course_model.dart';

class FieldFormCourseEnrollment extends StatefulWidget {
  final EnrollmentBloc enrollmentBloc;
  final CourseModel course;
  final List<CourseModel> courses;

  const FieldFormCourseEnrollment({
    super.key,
    required this.enrollmentBloc,
    required this.course,
    required this.courses,
  });

  @override
  State<FieldFormCourseEnrollment> createState() =>
      _FieldFormCourseEnrollmentState();
}

class _FieldFormCourseEnrollmentState extends State<FieldFormCourseEnrollment> {
  TextEditingController controller = TextEditingController();
  CourseModel selectedCourse = CourseModel.empty();
  EnrollmentModel enrollment = EnrollmentModel.empty();

  @override
  void initState() {
    super.initState();
    _initializeCourse();
  }

  void _initializeCourse() {
    if (widget.course.description.isNotEmpty) {
      controller.text = widget.course.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EnrollmentBloc, EnrollmentState>(
      bloc: widget.enrollmentBloc,
      builder: (context, state) {
        if (state is CurrentEnrollmentState) {
          enrollment = state.enrollment;
          selectedCourse = state.enrollment
              .course; // Assuming you added course to EnrollmentModel
          controller.text = selectedCourse.description;
        }

        return TextFormField(
          key: const Key("FieldInputCourse"),
          controller: controller,
          readOnly: true,
          decoration: VRInputDecoration.decoration(
            context: context,
            labelText: 'Curso',
            hintText: 'Selecione um curso',
          ),
          onTap: _handleTapField,
        );
      },
    );
  }

  Future<void> _handleTapField() async {
    CourseModel? courseResult = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return VRAppSearchSelect<CourseModel>(
          initialValue: selectedCourse,
          filterDelegate: (item, text) {
            return item.description.toLowerCase().contains(text.toLowerCase());
          },
          items: widget.courses,
          buildItemDelegate: (context, index, item) {
            return ListTile(
              title: Text(
                item.description,
                textAlign: TextAlign.center,
              ),
            );
          },
        );
      },
    );

    if (courseResult != null) {
      selectedCourse = courseResult;
      controller.text = courseResult.description;
      enrollment = enrollment.copyWith(
          course:
              selectedCourse); // Assuming you added course to EnrollmentModel

      widget.enrollmentBloc.add(CurrentEnrollmentEvent(enrollment));
    }
  }
}
