import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vr_curso_app/app/core/shared/widgets/vr_progress.dart';
import 'package:vr_curso_app/app/modules/student/presenter/blocs/state/student_state.dart';
import 'package:vr_curso_app/app/modules/student/presenter/models/student_model.dart';
import 'package:vr_curso_app/app/modules/student/presenter/widgets/vr_form.dart';

import '../../../message_center/domain/enums/message_type.dart';
import '../blocs/student_bloc.dart';
import '../store/student_store.dart';

class CreateStudentPage extends StatelessWidget {
  final StudentStore store;
  final StudentBloc bloc;
  const CreateStudentPage({super.key, required this.store, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StudentBloc>(
      create: (BuildContext context) => bloc,
      child: BodyStudent(
        store: store,
        bloc: bloc,
      ),
    );
  }
}

class BodyStudent extends StatefulWidget {
  final StudentStore store;
  final StudentBloc bloc;

  const BodyStudent({super.key, required this.store, required this.bloc});

  @override
  State<BodyStudent> createState() => _BodyStudentState();
}

class _BodyStudentState extends State<BodyStudent> {
  final keyFormStudent = GlobalKey<FormState>();
  StudentModel student = StudentModel.empty();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cadastrar Aluno'),
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
                    student = state.student;
                  }
                  if (state is CurrentStudentState) {
                    student = state.student;
                    widget.store.setStudent(student);
                    log('Auvindo student name em Page Student ${student.name}');
                  }

                  if (state is CreateStudentSuccessState) {
                    log('Aluno cadastrado com sucesso!');
                    isLoading = false;
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      widget.store.message.creatMessage(
                        message: 'Aluno cadastrado com sucesso!',
                        color: colorScheme,
                        icon: Icons.check,
                        type: MessageType.success,
                      );
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
                        isUpdate: false,
                          student: student,
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
