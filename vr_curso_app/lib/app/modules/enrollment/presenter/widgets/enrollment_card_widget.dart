import 'package:flutter/material.dart';
import 'package:vr_curso_app/app/modules/enrollment/presenter/models/enrollment_model.dart';
import 'package:vr_curso_app/app/modules/enrollment/presenter/store/enrollment_store.dart';
import '../../../../core/shared/widgets/dailog_material_decision.dart';
import '../blocs/enrrollment_bloc.dart';
import '../blocs/event/enrrollment_event.dart';

class EnrollmentCardWidget extends StatelessWidget {
  final EnrollmentModel enrollment;
  final EnrollmentStore store;
  final EnrollmentBloc bloc;

  const EnrollmentCardWidget({
    super.key,
    required this.enrollment,
    required this.store,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Card(
      key: const Key('_enrollmentCardWidget_'),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.center,
        onLongPress: () {
          showDialogMaterialDecision(
            message: 'Deseja excluir a matrícula?',
            context: context,
            title: 'Excluir',
            functionYes: () {
              bloc.add(DeleteEnrollmentEvent(enrollment));
            },
          );
        },
        isThreeLine: true,
        iconColor: color.primary,
        leading: const Icon(
          Icons.person_outlined, // Ícone representando o aluno/matrícula
          size: 32,
        ),
        title: Text(
          'Aluno: ${enrollment.student.name}',
          textAlign: TextAlign.center,
        ),
        subtitle: Text('Curso: ${enrollment.course.description}',
            textAlign: TextAlign.center),
      ),
    );
  }

  Future<void> onPressed(BuildContext ctx) async {
    dynamic isUpdate = await Navigator.pushNamed(
      ctx,
      '/enrollment_module/edit_enrollment_page',
      arguments: enrollment,
    );

    if (isUpdate is bool && isUpdate == true) {
      store.getAllEnrollments(bloc);
    }
  }
}
