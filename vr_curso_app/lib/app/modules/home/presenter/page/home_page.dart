import 'package:flutter/material.dart';
import 'package:vr_curso_app/app/modules/home/presenter/widgets/button_home.dart';
import 'package:vr_curso_app/app/modules/home/presenter/widgets/container_panel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = (size.height / 100);
    final width = (size.width / 100);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('VR CURSO'),
      ),
      body: SizedBox(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 5,
            ),
            SizedBox(
              height: 160,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ButtonMainHome(
                    icon: Icons.people_alt_outlined,
                    text: 'Aluno',
                    onTap: () {
                      Navigator.pushNamed(
                          context, '/student_module/student_page');
                    },
                  ),
                  ButtonMainHome(
                    icon: Icons.local_library_outlined,
                    text: 'Curso',
                    onTap: () {
                      Navigator.pushNamed(
                          context, '/course_module/course_page');
                    },
                  ),
                  ButtonMainHome(
                    icon: Icons.library_books,
                    text: 'Matricula',
                    onTap: () {
                      Navigator.pushNamed(
                          context, '/enrollment_module/enrollment_page');
                    },
                  ),
                ],
              ),
            ),
            ContainerPanel(
                inputs: InputContainer(
                    text: 'Curso', height: height * 35, width: width * 98))
          ],
        ),
      ),
    );
  }
}
