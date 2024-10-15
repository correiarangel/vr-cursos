import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vr_curso_app/app/modules/student/domain/usecase/create_student_usecase.dart';
import 'package:vr_curso_app/app/modules/student/domain/usecase/delete_student_usecase.dart';
import 'package:vr_curso_app/app/modules/student/domain/usecase/get_all_student_usecase.dart';
import 'package:vr_curso_app/app/modules/student/domain/usecase/get_student_usecase.dart';
import 'package:vr_curso_app/app/modules/student/domain/usecase/update_student_usecase.dart';
import 'package:vr_curso_app/app/modules/student/presenter/models/student_model.dart';

import '../../exception/student_exception.dart';
import 'event/student_event.dart';
import 'state/student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final ICreateStudentUsecase createUsecase;
  final IGetAllStudentUsecase getAllUsecase;
  final IGetStudentUsecase getUsecase;
  final IUpdateStudentUsecase updateUsecase;
  final IDeleteStudentUsecase deleteUsecase;
  StudentBloc({
    required this.deleteUsecase,
    required this.createUsecase,
    required this.getAllUsecase,
    required this.getUsecase,
    required this.updateUsecase,
  }) : super(StudentInitialState()) {
    on<CreateStudentEvent>(_onCreate);
    on<UpdateStudentEvent>(_onUpdate);
    on<LoadingStudentEvent>(_setLoading);
    on<GetStudentEvent>(_onGet);
    on<GetAllStudentEvent>(_onGetAll);
    on<ChangedStudentInitalEvent>(_onSetInit);
    on<DeleteStudentEvent>(_onDelete);
    on<CurretStudentEvent>(_onChangesStudent);
  }

  Future<void> _onCreate(CreateStudentEvent event, Emitter emit) async {
    emit(CreateStudentLoadingState());

    final result =
        await createUsecase.call(StudentModel.fromDTO(event.student));

    result.fold(
      (failure) => emit(
        StudentExceptionState(
          StudentException(
            message: failure.message,
            stackTrace: StackTrace.current,
          ),
        ),
      ),
      (student) =>
          emit(CreateStudentSuccessState(StudentModel.fromModel(student))),
    );
    // emit(StudentInitialState());
  }

  FutureOr<void> _setLoading(
      LoadingStudentEvent event, Emitter<StudentState> emit) {
    emit(StudentLoadingState());
  }

  FutureOr<void> _onSetInit(
      ChangedStudentInitalEvent event, Emitter<StudentState> emit) {
    emit(StudentInitialState());
  }

  FutureOr<void> _onGet(
      GetStudentEvent event, Emitter<StudentState> emit) async {
    emit(StudentLoadingState());

    final result = await getUsecase(StudentModel.fromDTO(event.studen));
    result.fold(
      (error) {
        emit(
          StudentExceptionState(
            StudentException(
              message: error.message,
              stackTrace: StackTrace.current,
            ),
          ),
        );
      },
      (student) {
        emit(
          GetStudentSuccessState(
            StudentModel.fromModel(student),
          ),
        );
      },
    );
  }

  FutureOr<void> _onUpdate(
      UpdateStudentEvent event, Emitter<StudentState> emit) async {
    emit(StudentLoadingState());

    final registerEdit =
        await updateUsecase(StudentModel.fromDTO(event.student));
    registerEdit.fold(
      (error) {
        emit(
          StudentExceptionState(
            StudentException(
              message: error.message,
              stackTrace: StackTrace.current,
            ),
          ),
        );
      },
      (student) {
        log(' student Edit ///--- $student');
        emit(UpdateStudentSuccessState(StudentModel.fromModel(student)));
      },
    );
  }

  FutureOr<void> _onDelete(
      DeleteStudentEvent event, Emitter<StudentState> emit) async {
    emit(StudentLoadingState());

    final studentDelete =
        await deleteUsecase(StudentModel.fromDTO(event.student));
    studentDelete.fold(
      (error) {
        emit(
          StudentExceptionState(
            StudentException(
              message: error.message,
              stackTrace: StackTrace.current,
            ),
          ),
        );
      },
      (isDelete) {
        if (isDelete) emit(DeleteStudentSuccessState());
        if (!isDelete) {
          emit(
            StudentExceptionState(
              StudentException(
                message: 'OPS! algo errado aluno não foi excluido',
                stackTrace: StackTrace.current,
              ),
            ),
          );
        }
      },
    );
  }

  FutureOr<void> _onGetAll(
      GetAllStudentEvent event, Emitter<StudentState> emit) async {
    emit(StudentLoadingState());

    final result = await getAllUsecase();
    result.fold(
      (error) {
        emit(
          StudentExceptionState(
            StudentException(
              message: error.message,
              stackTrace: StackTrace.current,
            ),
          ),
        );
      },
      (students) {
        emit(
          GetAllStudentSuccessState(StudentModel.fromListModel(students)),
        );
      },
    );
  }

  FutureOr<void> _onChangesStudent(
      CurretStudentEvent event, Emitter<StudentState> emit) {
    emit(CurrentStudentState(event.student));
  }
}
