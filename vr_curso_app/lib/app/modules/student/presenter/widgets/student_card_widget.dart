import 'package:flutter/material.dart';
import 'package:vr_curso_app/app/modules/student/presenter/blocs/event/student_event.dart';
import 'package:vr_curso_app/app/modules/student/presenter/blocs/student_bloc.dart';
import 'package:vr_curso_app/app/modules/student/presenter/models/student_model.dart';
import 'package:vr_curso_app/app/modules/student/presenter/store/student_store.dart';

import '../../../../core/shared/widgets/dailog_material_decision.dart';

class StudentCardWidget extends StatelessWidget {
  final StudentModel student;
  final StudentStore store;
  final StudentBloc bloc;
  const StudentCardWidget({
    super.key,
    required this.student,
    required this.store,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Card(
      key: const Key('_studentCardWidget_'),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        onLongPress: () {
          showDialogMaterialDecision(
              message: 'Desejá excluir Aluno?',
              context: context,
              title: 'Excluir',
              functionYes: () {
                bloc.add(DeleteStudentEvent(student));
              });
        },
        isThreeLine: true,
        iconColor: color.primary,
        leading: const Icon(
          Icons.school_outlined,
          size: 32,
        ),
        title: Text(student.name),
        subtitle:
            Text('Matriculado em : ${student.enrollmentIds.length} curso(s)'),
        trailing: IconButton(
            onPressed:()=> onPressed(context),
            icon: const Icon(Icons.edit_calendar_outlined)),
      ),
    );
  }

  Future<void> onPressed(BuildContext ctx) async {
    dynamic isUpdate = await Navigator.pushNamed(
      ctx,
      '/student_module/edit_student_page',
      arguments: student,
    );

    if (isUpdate is bool && isUpdate == true) {
     store.getAllStudents(bloc);
    }
  }
}
