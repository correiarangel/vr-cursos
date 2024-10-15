import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vr_curso_app/app/core/shared/widgets/vr_input_decuration.dart';
import 'package:vr_curso_app/app/modules/student/presenter/blocs/event/student_event.dart';
import 'package:vr_curso_app/app/modules/student/presenter/blocs/state/student_state.dart';
import 'package:vr_curso_app/app/modules/student/presenter/blocs/student_bloc.dart';
import 'package:vr_curso_app/app/modules/student/presenter/models/student_model.dart';
import 'package:vr_curso_app/app/modules/student/presenter/store/student_store.dart';

class VRTextFormField extends StatefulWidget {
  final StudentInputPage input;
  final StudentBloc bloc;
  const VRTextFormField({
    super.key,
    required this.input,
    required this.bloc,
  });

  @override
  State<VRTextFormField> createState() => _VRTextFormFieldState();
}

class _VRTextFormFieldState extends State<VRTextFormField> {
  final TextEditingController controller = TextEditingController();

  StudentModel student = StudentModel.empty();

  @override
  void initState() {
    if (widget.input.student != null) {
      _initText(widget.input.student!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StudentBloc, StudentState>(
      bloc: widget.bloc,
      listener: (context, state) {
        if (state is CurrentStudentState) {
          student = state.student;
          log('Auvindo student name ${student.name}');
        }
      },
      child: TextFormField(
        key: const Key('FieldStudent'),
        controller: controller,
        textCapitalization: TextCapitalization.characters,
        onChanged: onChanged,
        validator: widget.input.store.validName,
        maxLength: 50,
        decoration: VRInputDecoration.decoration(
            context: context,
            labelText: 'Nome',
            hintText: 'Digite o nome do aluno...'
            /*     suffixIcon: ClearTextFieldIcon(
                  key: const Key("ClearFieldComplementEdit"),
                  show: true,
                  onPressed: () => _handleTapField(''),
                ), */
            ),
      ),
    );
  }

  void onChanged(String value) {
    student = student.copyWith(name: value);
    widget.bloc.add(CurretStudentEvent(student));
  }

  void _initText(StudentModel student) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.text = student.name;
    });
  }
}

class StudentInputPage {
  final StudentStore store;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final IconData icon;
  final StudentModel? student;

  StudentInputPage({
    required this.store,
    required this.textInputType,
    required this.validator,
    required this.icon,
    this.student,
  });
}
