import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vr_curso_app/app/core/shared/widgets/vr_progress.dart';
import 'package:vr_curso_app/app/modules/student/presenter/blocs/event/student_event.dart';
import 'package:vr_curso_app/app/modules/student/presenter/blocs/state/student_state.dart';
import 'package:vr_curso_app/app/modules/student/presenter/models/student_model.dart';
import 'package:vr_curso_app/app/modules/student/presenter/widgets/vr_form.dart';

import '../../../message_center/domain/enums/message_type.dart';
import '../blocs/student_bloc.dart';
import '../store/student_store.dart';

class EditStudentPage extends StatelessWidget {
  final StudentStore store;
  final StudentBloc bloc;
  final StudentModel student;
  const EditStudentPage(
      {super.key,
      required this.store,
      required this.bloc,
      required this.student});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StudentBloc>(
      create: (BuildContext context) => bloc,
      child: BodyStudentEdit(
        student: student,
        store: store,
        bloc: bloc,
      ),
    );
  }
}

class BodyStudentEdit extends StatefulWidget {
  final StudentStore store;
  final StudentBloc bloc;
  final StudentModel student;
  const BodyStudentEdit({
    super.key,
    required this.store,
    required this.bloc,
    required this.student,
  });

  @override
  State<BodyStudentEdit> createState() => _BodyStudentEditState();
}

class _BodyStudentEditState extends State<BodyStudentEdit> {
  bool isLoading = false;
  @override
  void initState() {
    widget.bloc.add(CurretStudentEvent(widget.student));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Editar Aluno'),
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left),
          onPressed: () {
            Navigator.of(context).pop();
          }, //=> Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BlocBuilder<StudentBloc, StudentState>(
                bloc: widget.bloc,
                builder: (context, state) {
                  if (state is CreateStudentLoadingState) isLoading = true;

                  if (state is GetStudentSuccessState) {
                    isLoading = false;
                    widget.store.setStudent(state.student);
                  }
                  if (state is CurrentStudentState) {
                    widget.store.setStudent(state.student);
                  }

                  if (state is UpdateStudentSuccessState) {
                    log('Aluno atualisado com sucesso!');
                    isLoading = false;
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      widget.store.message.creatMessage(
                        message: 'Aluno atualisado com sucesso!',
                        color: colorScheme,
                        icon: Icons.check,
                        type: MessageType.success,
                      );
                      Navigator.of(context).pop(true);
                    });
                  }

                  if (state is StudentExceptionState) {
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
                      : VRForm(
                          isUpdate: true,
                          student: widget.student,
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
