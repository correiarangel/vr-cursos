import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vr_curso_app/app/modules/message_center/domain/enums/message_type.dart';

import '../../../../core/shared/widgets/not_value_widget.dart';
import '../../../../core/shared/widgets/vr_progress.dart';

import 'package:vr_curso_app/app/modules/enrollment/presenter/store/enrollment_store.dart';
import 'package:vr_curso_app/app/modules/enrollment/presenter/models/enrollment_model.dart';

import '../blocs/enrrollment_bloc.dart';
import '../blocs/state/enrrollment_state.dart';
import '../widgets/enrollment_card_widget.dart';

class EnrollmentPage extends StatefulWidget {
  final EnrollmentStore store;
  final EnrollmentBloc bloc;

  const EnrollmentPage({
    super.key,
    required this.store,
    required this.bloc,
  });

  @override
  State<EnrollmentPage> createState() => _EnrollmentPageState();
}

class _EnrollmentPageState extends State<EnrollmentPage> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    widget.store.getAllEnrollments(widget.bloc);
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
          'Matrículas',
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
          child: BlocBuilder<EnrollmentBloc, EnrollmentState>(
            bloc: widget.bloc,
            builder: (context, state) {
              if (state is CreateEnrollmentLoadingState) {
                isLoading = true;
              }

              if (state is GetAllEnrollmentSuccessState) {
                isLoading = false;
                widget.store.setEnrollments(state.enrollments);
              }

              if (state is UpdateEnrollmentSuccessState) {
                isLoading = false;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  widget.store.message.creatMessage(
                    message: 'Matrícula atualizada com sucesso!',
                    color: colorScheme,
                    icon: Icons.check,
                    type: MessageType.success,
                  );
                });
              }

              if (state is CreateEnrollmentSuccessState) {
                isLoading = false;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  widget.store.getAllEnrollments(widget.bloc);
                });
              }

              if (state is DeleteEnrollmentSuccessState) {
                isLoading = false;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  widget.store.message.creatMessage(
                    message: 'Matrícula deletada com sucesso!',
                    color: colorScheme,
                    icon: Icons.check,
                    type: MessageType.success,
                  );
                });
                widget.store.getAllEnrollments(widget.bloc);
              }

              if (state is EnrollmentExceptionState) {
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
                          visible: widget.store.enrollments.isNotEmpty,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: height * 78,
                                child: ListView.builder(
                                  itemCount: widget.store.enrollments.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    EnrollmentModel model =
                                        widget.store.enrollments[index];

                                    return EnrollmentCardWidget(
                                      bloc: widget.bloc,
                                      enrollment: model,
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
                              widget.store.getAllEnrollments(widget.bloc),
                          list: widget.store.enrollments,
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
    Navigator.pushNamed(ctx, '/enrollment_module/create_enrollment_page');
  }
}
