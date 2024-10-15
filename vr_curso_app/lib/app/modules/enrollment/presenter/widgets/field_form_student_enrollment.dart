import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vr_curso_app/app/core/shared/widgets/vr_app_search_select.dart';
import 'package:vr_curso_app/app/core/shared/widgets/vr_input_decuration.dart';

import 'package:vr_curso_app/app/modules/enrollment/presenter/blocs/enrrollment_bloc.dart';
import 'package:vr_curso_app/app/modules/enrollment/presenter/blocs/event/enrrollment_event.dart';
import 'package:vr_curso_app/app/modules/enrollment/presenter/models/enrollment_model.dart';

import '../../../student/presenter/models/student_model.dart';
import '../blocs/state/enrrollment_state.dart';

class FieldFormStudentEnrollment extends StatefulWidget {
  final EnrollmentBloc enrollmentBloc;
  final StudentModel student;
  final List<StudentModel> students;

  const FieldFormStudentEnrollment({
    super.key,
    required this.enrollmentBloc,
    required this.student,
    required this.students,
  });

  @override
  State<FieldFormStudentEnrollment> createState() =>
      _FieldFormStudentEnrollmentState();
}

class _FieldFormStudentEnrollmentState
    extends State<FieldFormStudentEnrollment> {
  TextEditingController controller = TextEditingController();
  StudentModel selectedStudent = StudentModel.empty();
  EnrollmentModel enrollment = EnrollmentModel.empty();
  @override
  void initState() {
    super.initState();
    _initializeStudent();
  }

  void _initializeStudent() {
    if (widget.student.name.isNotEmpty) {
      controller.text = widget.student.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EnrollmentBloc, EnrollmentState>(
      bloc: widget.enrollmentBloc,
      builder: (context, state) {
        if (state is CurrentEnrollmentState) {
          enrollment = state.enrollment;
          selectedStudent = state.enrollment.student;
          controller.text = selectedStudent.name;
        }

        return TextFormField(
          key: const Key("FieldInputStudent"),
          controller: controller,
          readOnly: true,
          decoration: VRInputDecoration.decoration(
              context: context,
              labelText: 'Estudante',
              hintText: 'Selecione um aluno'),
          onTap: _handleTapField,
        );
      },
    );
  }

  Future<void> _handleTapField() async {
    StudentModel? studentResult = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return VRAppSearchSelect<StudentModel>(
          initialValue: selectedStudent,
          filterDelegate: (item, text) {
            return item.name.toLowerCase().contains(text.toLowerCase());
          },
          items: widget.students,
          buildItemDelegate: (context, index, item) {
            return ListTile(
              titleAlignment: ListTileTitleAlignment.center,
              title: Text(item.name, textAlign: TextAlign.center),
            );
          },
        );
      },
    );

    if (studentResult != null) {
      selectedStudent = studentResult;
      controller.text = studentResult.name;
      enrollment = enrollment.copyWith(student: selectedStudent);

      widget.enrollmentBloc.add(CurrentEnrollmentEvent(enrollment));
    }
  }
}
