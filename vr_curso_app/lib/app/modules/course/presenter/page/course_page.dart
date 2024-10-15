import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vr_curso_app/app/modules/message_center/domain/enums/message_type.dart';

import '../../../../core/shared/widgets/not_value_widget.dart';
import '../../../../core/shared/widgets/vr_progress.dart';

import 'package:vr_curso_app/app/modules/course/presenter/blocs/course_bloc.dart';
import 'package:vr_curso_app/app/modules/course/presenter/store/course_store.dart';
import 'package:vr_curso_app/app/modules/course/presenter/widgets/course_card_widget.dart';
import 'package:vr_curso_app/app/modules/course/presenter/models/course_model.dart';

import '../../../course/presenter/blocs/state/course_state.dart';

class CoursePage extends StatefulWidget {
  final CourseStore store;
  final CourseBloc bloc;

  const CoursePage({
    super.key,
    required this.store,
    required this.bloc,
  });

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    widget.store.getAllCourses(widget.bloc);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width / 100;
    final height = MediaQuery.of(context).size.height / 100;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Cursos',
          style: TextStyle(),
        ),
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left),
          onPressed: () {
            Navigator.of(context).pop(); // Volta para a tela anterior
          },
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: width * 100,
          child: BlocBuilder<CourseBloc, CourseState>(
            bloc: widget.bloc,
            builder: (context, state) {
              if (state is CreateCourseLoadingState) {
                isLoading = true;
              }

              if (state is GetAllCourseSuccessState) {
                isLoading = false;
                widget.store.setCourses(state.courses);
              }

              if (state is UpdateCourseSuccessState) {
                isLoading = false;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  widget.store.message.creatMessage(
                    message: 'Curso atualisado com sucesso!',
                    color: colorScheme,
                    icon: Icons.check,
                    type: MessageType.success,
                  );
                });
              }

              if (state is CreateCourseSuccessState) {
                isLoading = false;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  widget.store.getAllCourses(widget.bloc);
                });
              }
              if (state is DeleteCourseSuccessState) {
                isLoading = false;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  widget.store.message.creatMessage(
                    message: 'Curso deletado com sucesso!',
                    color: colorScheme,
                    icon: Icons.check,
                    type: MessageType.success,
                  );
                });
                widget.store.getAllCourses(widget.bloc);
              }

              if (state is CourseExceptionState) {
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
                          visible: widget.store.courses.isNotEmpty,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: height * 78,
                                child: ListView.builder(
                                  itemCount: widget.store.courses.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    CourseModel model =
                                        widget.store.courses[index];

                                    return CourseCardWidget(
                                      bloc: widget.bloc,
                                      course: model,
                                      store: widget.store,
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                        NotValueWidget(
                          onPressed: () =>
                              widget.store.getAllCourses(widget.bloc),
                          list: widget.store.courses,
                        ),
                      ],
                    );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onPressed(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onPressed(BuildContext ctx) {
    Navigator.pushNamed(ctx, '/course_module/create_course_page');
  }
}
