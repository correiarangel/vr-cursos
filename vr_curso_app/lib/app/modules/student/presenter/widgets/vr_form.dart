import 'package:flutter/material.dart';
import 'package:vr_curso_app/app/modules/student/presenter/blocs/student_bloc.dart';
import 'package:vr_curso_app/app/modules/student/presenter/models/student_model.dart';

import 'package:vr_curso_app/app/modules/student/presenter/widgets/vr_text_form_field.dart';

import '../store/student_store.dart';

class VRForm extends StatefulWidget {
  final StudentBloc bloc;
  final StudentStore store;
  final StudentModel? student;
  final bool isUpdate;
  const VRForm({
    super.key,
    required this.store,
    required this.bloc,
    required this.student,
    required this.isUpdate,
  });

  @override
  State<VRForm> createState() => _VRFormState();
}

class _VRFormState extends State<VRForm> {
  final keyFormStudent = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Form(
      key: keyFormStudent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.15),
          VRTextFormField(
            bloc: widget.bloc,
            input: StudentInputPage(
              student: widget.student,
              store: widget.store,
              textInputType: TextInputType.name,
              icon: Icons.person,
              validator: widget.store.validName,
      
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                if (keyFormStudent.currentState!.validate()) {
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

/*   void onPressed() {
    if (widget.isUpdate) {
      widget.store.update(
        bloc: widget.bloc,
        student: widget.store.student,
      );
    }
    if (!widget.isUpdate) {
      widget.store.create(
        bloc: widget.bloc,
        name: widget.store.student.name,
      );
    }
  } */
}
