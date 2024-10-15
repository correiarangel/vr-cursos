import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vr_curso_app/app/core/value/const_http.dart';
import 'package:vr_curso_app/app/modules/course/presenter/blocs/event/course_event.dart';
import 'package:vr_curso_app/app/modules/course/presenter/models/course_model.dart';

import '../../../student/presenter/blocs/state/student_state.dart';
import '../../domain/usecasa/create_course_usecase.dart';
import '../../domain/usecasa/delete_course_usecase.dart';
import '../../domain/usecasa/get_all_course_usecase.dart';
import '../../domain/usecasa/get_course_usecase.dart';
import '../../domain/usecasa/update_course_usecase.dart';
import '../../exception/course_exception.dart';
import 'state/course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final ICreateCourseUsecase createUsecase;
  final IGetAllCourseUsecase getAllUsecase;
  final IGetCourseUsecase getUsecase;
  final IUpdateCourseUsecase updateUsecase;
  final IDeleteCourseUsecase deleteUsecase;

  CourseBloc({
    required this.deleteUsecase,
    required this.createUsecase,
    required this.getAllUsecase,
    required this.getUsecase,
    required this.updateUsecase,
  }) : super(CourseInitialState()) {
    on<CreateCourseEvent>(_onCreate);
    on<UpdateCourseEvent>(_onUpdate);
    on<LoadingCourseEvent>(_setLoading);
    on<GetCourseEvent>(_onGet);
    on<GetAllCourseEvent>(_onGetAll);
    on<ChangedCourseInitalEvent>(_onSetInit);
    on<DeleteCourseEvent>(_onDelete);
    on<CurrentCourseEvent>(_onChangesCourse);
  }

  Future<void> _onCreate(CreateCourseEvent event, Emitter emit) async {
    emit(CreateCourseLoadingState());

    final result = await createUsecase.call(CourseModel.fromDTO(event.course));

    result.fold(
      (failure) => emit(
        CourseExceptionState(
          CourseException(
            message: failure.message,
            stackTrace: StackTrace.current,
          ),
        ),
      ),
      (course) =>
          emit(CreateCourseSuccessState(CourseModel.fromEntity(course))),
    );
    // emit(CourseInitialState());
  }

  FutureOr<void> _setLoading(
      LoadingCourseEvent event, Emitter<CourseState> emit) {
    emit(CourseLoadingState());
  }

  FutureOr<void> _onSetInit(
      ChangedCourseInitalEvent event, Emitter<CourseState> emit) {
    emit(CourseInitialState());
  }

  FutureOr<void> _onGet(GetCourseEvent event, Emitter<CourseState> emit) async {
    emit(CourseLoadingState());

    final result = await getUsecase(CourseModel.fromDTO(event.studen));
    result.fold(
      (error) {
        emit(
          CourseExceptionState(
            CourseException(
              message: error.message,
              stackTrace: StackTrace.current,
            ),
          ),
        );
      },
      (course) {
        emit(
          GetCourseSuccessState(
            CourseModel.fromEntity(course),
          ),
        );
      },
    );
  }

  FutureOr<void> _onUpdate(
      UpdateCourseEvent event, Emitter<CourseState> emit) async {
    emit(CourseLoadingState());

    final registerEdit = await updateUsecase(CourseModel.fromDTO(event.course));
    registerEdit.fold(
      (error) {
        emit(
          CourseExceptionState(
            CourseException(
              message: error.message,
              stackTrace: StackTrace.current,
            ),
          ),
        );
      },
      (course) {
        log(' course Edit ///--- $course');
        emit(UpdateCourseSuccessState(CourseModel.fromEntity(course)));
      },
    );
  }

  FutureOr<void> _onDelete(
      DeleteCourseEvent event, Emitter<CourseState> emit) async {
    emit(CourseLoadingState());

    final courseDelete = await deleteUsecase(CourseModel.fromDTO(event.course));
    courseDelete.fold(
      (error) {
        String msg = error.message;
        if (error.message
            .contains('Unexpected error deleting student: Instance of')) {
          msg = ConstHttp.dioMessageErrorValidRequest;
        }
        emit(
          CourseExceptionState(
            CourseException(
              message: msg,
              stackTrace: StackTrace.current,
            ),
          ),
        );
      },
      (isDelete) {
        if (isDelete) emit(DeleteCourseSuccessState());
        if (!isDelete) {
          emit(
            CourseExceptionState(
              CourseException(
                message: 'OPS! algo errado curso não foi excluido',
                stackTrace: StackTrace.current,
              ),
            ),
          );
        }
      },
    );
  }

  FutureOr<void> _onGetAll(
      GetAllCourseEvent event, Emitter<CourseState> emit) async {
    emit(CourseLoadingState());

    final result = await getAllUsecase();
    result.fold(
      (error) {
        emit(
          CourseExceptionState(
            CourseException(
              message: error.message,
              stackTrace: StackTrace.current,
            ),
          ),
        );
      },
      (courses) {
        emit(
          GetAllCourseSuccessState(CourseModel.fromListEntity(courses)),
        );
      },
    );
  }

  FutureOr<void> _onChangesCourse(
      CurrentCourseEvent event, Emitter<CourseState> emit) {
    emit(CurrentCourseState(event.course));
  }
}
