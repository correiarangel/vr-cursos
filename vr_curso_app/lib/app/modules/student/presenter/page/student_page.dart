import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vr_curso_app/app/modules/message_center/domain/enums/message_type.dart';
import 'package:vr_curso_app/app/modules/student/presenter/blocs/state/student_state.dart';

import 'package:vr_curso_app/app/modules/student/presenter/blocs/student_bloc.dart';
import 'package:vr_curso_app/app/modules/student/presenter/models/student_model.dart';
import 'package:vr_curso_app/app/modules/student/presenter/store/student_store.dart';
import 'package:vr_curso_app/app/modules/student/presenter/widgets/student_card_widget.dart';

import '../../../../core/shared/widgets/vr_progress.dart';
import '../widgets/not_student_widget.dart';

class StudentPage extends StatefulWidget {
  final StudentStore store;
  final StudentBloc bloc;
  const StudentPage({
    super.key,
    required this.store,
    required this.bloc,
  });

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  // List <StudentModel> students = [];
  @override
  void initState() {
    widget.store.getAllStudents(widget.bloc);
    super.initState();
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width / 100;
    final height = MediaQuery.of(context).size.height / 100;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Alunos',
          style: TextStyle(),
        ),
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left),
          onPressed: () {
            Navigator.of(context).pop();
          }, //=> Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: width * 100,
          child: BlocBuilder<StudentBloc, StudentState>(
            bloc: widget.bloc,
            builder: (context, state) {
              if (state is CreateStudentLoadingState) isLoading = true;

              if (state is GetAllStudentSuccessState) {
                isLoading = false;
                widget.store.setStudents(state.students);
              }

              if (state is UpdateStudentSuccessState) {
                isLoading = false;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  widget.store.message.creatMessage(
                    message: 'Aluno atualisado com sucesso!',
                    color: colorScheme,
                    icon: Icons.check,
                    type: MessageType.success,
                  );
                });
              }
              if (state is DeleteStudentSuccessState) {
                isLoading = false;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  widget.store.message.creatMessage(
                    message: 'Aluno deletado com sucesso!',
                    color: colorScheme,
                    icon: Icons.check,
                    type: MessageType.success,
                  );
                });
                widget.store.getAllStudents(widget.bloc);
              }

              if (state is StudentExceptionState) {
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
                  ? VRProgress(
                      height: height * 35,
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(height: 16),
                        Visibility(
                          visible: widget.store.students.isNotEmpty,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: height * 78,
                                child: ListView.builder(
                                  itemCount: widget.store.students.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    StudentModel model =
                                        widget.store.students[index];

                                    return StudentCardWidget(
                                      bloc: widget.bloc,
                                      student: model,
                                      store: widget.store,
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                        NotStudentWidget(
                          store: widget.store,
                          onPressed: () =>
                              widget.store.getAllStudents(widget.bloc),
                          students: widget.store.students,
                        ),
                      ],
                    );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/student_module/create_student_page');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
