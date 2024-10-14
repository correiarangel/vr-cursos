import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vr_curso_app/app/core/types/either.dart';
import 'package:vr_curso_app/app/modules/student/domain/student_dto/student_dto.dart';
import 'package:vr_curso_app/app/modules/student/domain/usecase/create_student_usecase.dart';
import 'package:vr_curso_app/app/modules/student/domain/usecase/delete_student_usecase.dart';
import 'package:vr_curso_app/app/modules/student/domain/usecase/get_all_student_usecase.dart';
import 'package:vr_curso_app/app/modules/student/domain/usecase/get_student_usecase.dart';
import 'package:vr_curso_app/app/modules/student/domain/usecase/update_student_usecase.dart';
import 'package:vr_curso_app/app/modules/student/exception/student_exception.dart';
import 'package:vr_curso_app/app/modules/student/presenter/blocs/event/student_event.dart';
import 'package:vr_curso_app/app/modules/student/presenter/blocs/state/student_state.dart';
import 'package:vr_curso_app/app/modules/student/presenter/blocs/student_bloc.dart';
import 'package:vr_curso_app/app/modules/student/presenter/models/student_model.dart';

import '../../../../mocks/mocks.dart';

/// Fake for StudentDTO
class StudentDTOFake extends Fake implements StudentDTO {}

/// Fake for StudentModel
class StudentModelFake extends Fake implements StudentModel {}

class CreateStudentUsecaseMock extends Mock implements ICreateStudentUsecase {}

class GetAllStudentUsecaseMock extends Mock implements IGetAllStudentUsecase {}

class GetStudentUsecaseMock extends Mock implements IGetStudentUsecase {}

class UpdateStudentUseCaseMock extends Mock implements IUpdateStudentUsecase {}

class DeleteStudentUsecaseMock extends Mock implements IDeleteStudentUsecase {}

void main() {
  late ICreateStudentUsecase createStudentUsecaseMock;
  late IGetAllStudentUsecase getAllStudentUsecaseMock;
  late IGetStudentUsecase getStudentUsecaseMock;
  late IUpdateStudentUsecase updateStudentUsecaseMock;
  late IDeleteStudentUsecase deleteStudentUsecaseMock;
  late StudentBloc studentBlocMock;

  /// Register Fakes in setUpAll
  setUpAll(() {
    registerFallbackValue(StudentDTOFake());
    registerFallbackValue(StudentModelFake());
  });

  setUp(() {
    createStudentUsecaseMock = CreateStudentUsecaseMock();
    getAllStudentUsecaseMock = GetAllStudentUsecaseMock();
    getStudentUsecaseMock = GetStudentUsecaseMock();
    updateStudentUsecaseMock = UpdateStudentUseCaseMock();
    deleteStudentUsecaseMock = DeleteStudentUsecaseMock();

    studentBlocMock = StudentBloc(
      createUsecase: createStudentUsecaseMock,
      getAllUsecase: getAllStudentUsecaseMock,
      getUsecase: getStudentUsecaseMock,
      updateUsecase: updateStudentUsecaseMock,
      deleteUsecase: deleteStudentUsecaseMock,
    );
  });

  tearDown(() {
    studentBlocMock.close();
  });

  group(
    'StudentBloc, happy path',
    () {
      blocTest<StudentBloc, StudentState>(
        'Should return states [CreateStudentLoadingState, CreateStudentSuccessState] when creating a student',
        build: () {
          when(() => createStudentUsecaseMock.call(any()))
              .thenAnswer((_) async => right(studentEntityMock));

          return studentBlocMock;
        },
        act: (bloc) => bloc
            .add(CreateStudentEvent(StudentModel.fromModel(studentEntityMock))),
        expect: () => [
          isA<CreateStudentLoadingState>(),
          isA<CreateStudentSuccessState>(),
        ],
        verify: (_) {
          verify(() => createStudentUsecaseMock.call(any())).called(1);
        },
      );

      blocTest<StudentBloc, StudentState>(
        'Should return states [StudentLoadingState, GetAllStudentSuccessState] when fetching all students',
        build: () {
          when(() => getAllStudentUsecaseMock.call())
              .thenAnswer((_) async => right(studentListEntityMock));
          return studentBlocMock;
        },
        act: (bloc) => bloc.add(GetAllStudentEvent()),
        expect: () => [
          isA<StudentLoadingState>(), // Loading state
          isA<GetAllStudentSuccessState>(), // Success state when fetching students
        ],
        verify: (_) {
          verify(() => getAllStudentUsecaseMock.call()).called(1);
        },
      );

      blocTest<StudentBloc, StudentState>(
        'Should return states [StudentLoadingState, GetStudentSuccessState] when fetching a student',
        build: () {
          when(() => getStudentUsecaseMock.call(any()))
              .thenAnswer((_) async => right(studentEntityMock));
          return studentBlocMock;
        },
        act: (bloc) => bloc
            .add(GetStudentEvent(StudentModel.fromModel(studentEntityMock))),
        expect: () => [
          isA<StudentLoadingState>(), // Loading state
          isA<GetStudentSuccessState>(), // Success state when fetching student
        ],
        verify: (_) {
          verify(() => getStudentUsecaseMock.call(any())).called(1);
        },
      );

      blocTest<StudentBloc, StudentState>(
        'Should return states [StudentLoadingState, UpdateStudentSuccessState] when updating a student',
        build: () {
          when(() => updateStudentUsecaseMock.call(any()))
              .thenAnswer((_) async => right(studentEntityMock));
          return studentBlocMock;
        },
        act: (bloc) => bloc
            .add(UpdateStudentEvent(StudentModel.fromModel(studentEntityMock))),
        expect: () => [
          isA<StudentLoadingState>(),
          isA<UpdateStudentSuccessState>(),
        ],
        verify: (_) {
          verify(() => updateStudentUsecaseMock.call(any())).called(1);
        },
      );

      blocTest<StudentBloc, StudentState>(
        'Should return states [StudentLoadingState, DeleteStudentSuccessState] when deleting a student',
        build: () {
          when(() => deleteStudentUsecaseMock.call(any()))
              .thenAnswer((_) async => right(true));
          return studentBlocMock;
        },
        act: (bloc) => bloc
            .add(DeleteStudentEvent(StudentModel.fromModel(studentEntityMock))),
        expect: () => [
          isA<StudentLoadingState>(),
          isA<DeleteStudentSuccessState>(),
        ],
        verify: (_) {
          verify(() => deleteStudentUsecaseMock.call(any())).called(1);
        },
      );
    },
  );

  group(
    'StudentBloc, sad path',
    () {
      blocTest<StudentBloc, StudentState>(
        'Should return states [StudentLoadingState, StudentExceptionState] when failing to create a student',
        build: () {
          when(() => createStudentUsecaseMock.call(any())).thenAnswer(
              (_) async => left(const StudentException(
                  message: 'Failed to create student',
                  stackTrace: StackTrace.empty)));
          return studentBlocMock;
        },
        act: (bloc) => bloc
            .add(CreateStudentEvent(StudentModel.fromModel(studentEmptyMock))),
        expect: () => [
          isA<CreateStudentLoadingState>(),
          isA<StudentExceptionState>(),
        ],
        verify: (_) {
          verify(() => createStudentUsecaseMock.call(any())).called(1);
        },
      );

      blocTest<StudentBloc, StudentState>(
        'Should return states [StudentLoadingState, StudentExceptionState] when failing to delete a student',
        build: () {
          when(() => deleteStudentUsecaseMock.call(any())).thenAnswer(
              (_) async => left(const StudentException(
                  message: 'Failed to delete student',
                  stackTrace: StackTrace.empty)));
          return studentBlocMock;
        },
        act: (bloc) => bloc
            .add(DeleteStudentEvent(StudentModel.fromModel(studentEmptyMock))),
        expect: () => [
          isA<StudentLoadingState>(),
          isA<StudentExceptionState>(),
        ],
        verify: (_) {
          verify(() => deleteStudentUsecaseMock.call(any())).called(1);
        },
      );

      blocTest<StudentBloc, StudentState>(
        'Should return states [StudentLoadingState, StudentExceptionState] when  failing to  updating a student',
        build: () {
          when(() => updateStudentUsecaseMock.call(any())).thenAnswer(
              (_) async => left(const StudentException(
                  message: 'Failed to update student',
                  stackTrace: StackTrace.empty)));
          return studentBlocMock;
        },
        act: (bloc) => bloc
            .add(UpdateStudentEvent(StudentModel.fromModel(studentEmptyMock))),
        expect: () => [
          isA<StudentLoadingState>(),
          isA<StudentExceptionState>(),
        ],
        verify: (_) {
          verify(() => updateStudentUsecaseMock.call(any())).called(1);
        },
      );

      blocTest<StudentBloc, StudentState>(
        'Should return states [StudentLoadingState, StudentExceptionState] when fetching a  student failing  ',
        build: () {
          when(() => getStudentUsecaseMock.call(any())).thenAnswer((_) async =>
              left(const StudentException(
                  message: 'Failed to get student',
                  stackTrace: StackTrace.empty)));
          return studentBlocMock;
        },
        act: (bloc) =>
            bloc.add(GetStudentEvent(StudentModel.fromModel(studentEmptyMock))),
        expect: () => [
          isA<StudentLoadingState>(), // Loading state
          isA<StudentExceptionState>(), // Success state when fetching student
        ],
        verify: (_) {
          verify(() => getStudentUsecaseMock.call(any())).called(1);
        },
      );

      blocTest<StudentBloc, StudentState>(
        'Should return states [StudentLoadingState, StudentExceptionState] when fetching all students',
        build: () {
          when(() => getAllStudentUsecaseMock.call()).thenAnswer((_) async =>
              left(const StudentException(
                  message: 'Failed to get student',
                  stackTrace: StackTrace.empty)));
          return studentBlocMock;
        },
        act: (bloc) => bloc.add(GetAllStudentEvent()),
        expect: () => [
          isA<StudentLoadingState>(),
          isA<StudentExceptionState>(),
        ],
        verify: (_) {
          verify(() => getAllStudentUsecaseMock.call()).called(1);
        },
      );
    },
  );
}

