import 'package:flutter/material.dart';
import 'package:vr_curso_app/app/modules/course/presenter/blocs/event/course_event.dart';
import 'package:vr_curso_app/app/modules/course/presenter/models/course_model.dart';
import 'package:vr_curso_app/app/modules/course/presenter/store/course_store.dart';
import 'package:vr_curso_app/app/modules/course/presenter/blocs/course_bloc.dart';
import '../../../../core/shared/widgets/dailog_material_decision.dart';

class CourseCardWidget extends StatelessWidget {
  final CourseModel course;
  final CourseStore store;
  final CourseBloc bloc;

  const CourseCardWidget({
    super.key,
    required this.course,
    required this.store,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Card(
      key: const Key('_courseCardWidget_'),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.center,
        onLongPress: () {
          showDialogMaterialDecision(
            message: 'Deseja excluir o curso ?',
            context: context,
            title: 'Excluir',
            functionYes: () {
              bloc.add(DeleteCourseEvent(course));
            },
          );
        },
        isThreeLine: true,
        iconColor: color.primary,
        leading: const Icon(
          Icons.book_outlined, // Alterado para ícone de curso
          size: 32,
        ),
        title: Text(
          course.description,
          textAlign: TextAlign.center,
        ),
        subtitle: Text(
          'Ementa: ${course.syllabus}',
          textAlign: TextAlign.center,
        ),
        trailing: IconButton(
          onPressed: () => onPressed(context),
          icon: const Icon(Icons.edit_calendar_outlined),
        ),
      ),
    );
  }

  Future<void> onPressed(BuildContext ctx) async {
    dynamic isUpdate = await Navigator.pushNamed(
      ctx,
      '/course_module/edit_course_page',
      arguments: course,
    );

    if (isUpdate is bool && isUpdate == true) {
      store.getAllCourses(bloc);
    }
  }
}
