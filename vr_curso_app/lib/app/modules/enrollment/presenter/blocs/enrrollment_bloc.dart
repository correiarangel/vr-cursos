import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vr_curso_app/app/modules/course/presenter/blocs/course_bloc.dart';
import 'package:vr_curso_app/app/modules/enrollment/presenter/blocs/event/enrrollment_event.dart';
import 'package:vr_curso_app/app/modules/enrollment/presenter/models/enrollment_model.dart';
import 'package:vr_curso_app/app/modules/student/presenter/blocs/student_bloc.dart';

import '../../domain/usecasa/create_enrrollment_usecase.dart';
import '../../domain/usecasa/delete_enrrollment_usecase.dart';
import '../../domain/usecasa/get_all_enrrollment_usecase.dart';
import '../../domain/usecasa/get_enrrollment_usecase.dart';
import '../../domain/usecasa/update_enrrollment_usecase.dart';
import '../../exception/enrollment_exception.dart';
import 'state/enrrollment_state.dart';

class EnrollmentBloc extends Bloc<EnrollmentEvent, EnrollmentState> {
  final ICreateEnrollmentUsecase createUsecase;
  final IGetAllEnrollmentUsecase getAllUsecase;
  final IGetEnrollmentUsecase getUsecase;
  final IUpdateEnrollmentUsecase updateUsecase;
  final IDeleteEnrollmentUsecase deleteUsecase;
  final CourseBloc courseBloc;
  final StudentBloc studentBloc;

  EnrollmentBloc({
    required this.courseBloc,
    required this.studentBloc,
    required this.deleteUsecase,
    required this.createUsecase,
    required this.getAllUsecase,
    required this.getUsecase,
    required this.updateUsecase,
  }) : super(EnrollmentInitialState()) {
    on<CreateEnrollmentEvent>(_onCreate);
    on<UpdateEnrollmentEvent>(_onUpdate);
    on<LoadingEnrollmentEvent>(_setLoading);
    on<GetEnrollmentEvent>(_onGet);
    on<GetAllEnrollmentEvent>(_onGetAll);
    on<ChangedEnrollmentInitialEvent>(_onSetInit);
    on<DeleteEnrollmentEvent>(_onDelete);
    on<CurrentEnrollmentEvent>(_onChangesEnrollment);
  }

  Future<void> _onCreate(CreateEnrollmentEvent event, Emitter emit) async {
    emit(CreateEnrollmentLoadingState());

    final result = await createUsecase.call(
        param: EnrollmentModel.fromDTO(event.enrollment));

    result.fold(
      (failure) => emit(
        EnrollmentExceptionState(
          EnrollmentException(
            message: failure.message,
            stackTrace: StackTrace.current,
          ),
        ),
      ),
      (enrollment) => emit(
          CreateEnrollmentSuccessState(EnrollmentModel.fromModel(enrollment))),
    );
  }

  FutureOr<void> _setLoading(
      LoadingEnrollmentEvent event, Emitter<EnrollmentState> emit) {
    emit(EnrollmentLoadingState());
  }

  FutureOr<void> _onSetInit(
      ChangedEnrollmentInitialEvent event, Emitter<EnrollmentState> emit) {
    emit(EnrollmentInitialState());
  }

  FutureOr<void> _onGet(
      GetEnrollmentEvent event, Emitter<EnrollmentState> emit) async {
    emit(EnrollmentLoadingState());

    final result = await getUsecase(EnrollmentModel.fromDTO(event.enrollment));
    result.fold(
      (error) {
        emit(
          EnrollmentExceptionState(
            EnrollmentException(
              message: error.message,
              stackTrace: StackTrace.current,
            ),
          ),
        );
      },
      (enrollment) {
        emit(
          GetEnrollmentSuccessState(
            EnrollmentModel.fromModel(enrollment),
          ),
        );
      },
    );
  }

  FutureOr<void> _onUpdate(
      UpdateEnrollmentEvent event, Emitter<EnrollmentState> emit) async {
    emit(EnrollmentLoadingState());

    final registerEdit =
        await updateUsecase(EnrollmentModel.fromDTO(event.enrollment));
    registerEdit.fold(
      (error) {
        emit(
          EnrollmentExceptionState(
            EnrollmentException(
              message: error.message,
              stackTrace: StackTrace.current,
            ),
          ),
        );
      },
      (enrollment) {
        log(' enrollment Edit ///--- $enrollment');
        emit(UpdateEnrollmentSuccessState(
            EnrollmentModel.fromModel(enrollment)));
      },
    );
  }

  FutureOr<void> _onDelete(
      DeleteEnrollmentEvent event, Emitter<EnrollmentState> emit) async {
    emit(EnrollmentLoadingState());

    final enrollmentDelete =
        await deleteUsecase(EnrollmentModel.fromDTO(event.enrollment));
    enrollmentDelete.fold(
      (error) {
        emit(
          EnrollmentExceptionState(
            EnrollmentException(
              message: error.message,
              stackTrace: StackTrace.current,
            ),
          ),
        );
      },
      (isDelete) {
        if (isDelete) emit(DeleteEnrollmentSuccessState());
        if (!isDelete) {
          emit(
            EnrollmentExceptionState(
              EnrollmentException(
                message: 'OPS! algo errado, a matrícula não foi excluída',
                stackTrace: StackTrace.current,
              ),
            ),
          );
        }
      },
    );
  }

  FutureOr<void> _onGetAll(
      GetAllEnrollmentEvent event, Emitter<EnrollmentState> emit) async {
    emit(EnrollmentLoadingState());

    final result = await getAllUsecase();
    result.fold(
      (error) {
        emit(
          EnrollmentExceptionState(
            EnrollmentException(
              message: error.message,
              stackTrace: StackTrace.current,
            ),
          ),
        );
      },
      (enrollments) {
        emit(
          GetAllEnrollmentSuccessState(
              EnrollmentModel.fromListModel(enrollments)),
        );
      },
    );
  }

  FutureOr<void> _onChangesEnrollment(
      CurrentEnrollmentEvent event, Emitter<EnrollmentState> emit) {
    emit(CurrentEnrollmentState(event.enrollment));
  }
}
