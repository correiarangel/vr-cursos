import 'package:flutter/material.dart';
import 'package:vr_curso_app/app/modules/student/presenter/models/student_model.dart';
import 'package:vr_curso_app/app/modules/student/presenter/store/student_store.dart';

class NotStudentWidget extends StatelessWidget {
  final StudentStore store;
  final List<StudentModel> students;

  final void Function()? onPressed;
  const NotStudentWidget({
    super.key,
    required this.students,
    required this.onPressed,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width / 100;
    final height = MediaQuery.of(context).size.height / 100;
    return Visibility(
      visible: students.isEmpty,
      child: SizedBox(
        width: width * 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height * 25),
            const Text("OPS! ", style: TextStyle(fontSize: 32)),
            const SizedBox(height: 16),
            const Text(
              "Não há dados a exibir !...",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: onPressed,
              icon: const Icon(
                Icons.restart_alt,
                size: 32,
              ),
              label: const Text(
                'Recarregar',
                style: TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
