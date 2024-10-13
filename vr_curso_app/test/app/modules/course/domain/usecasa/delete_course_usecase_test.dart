import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vr_curso_app/app/core/types/either.dart';
import 'package:vr_curso_app/app/modules/course/domain/repositories/i_course_repository.dart';
import 'package:vr_curso_app/app/modules/course/domain/usecasa/delete_course_usecase.dart';
import 'package:vr_curso_app/app/modules/course/exception/course_exception.dart';

import '../../../../mocks/mocks.dart';


void main() {
  late ICourseRepository repository;

  setUp(() {
    repository = CourseRepositoryMock();
  });

  group('Delete Course Happy Path ;]', () {
    test('Should delete a CourseEntity ...', () async {
      // Arrange

      when(() => repository.delete(courseDTOMock)).thenAnswer(
        (_) async => right(true), // Returns success
      );

      // Act
      final usecase = DeleteCourseUsecase(repository);

      // Assert
      expect(usecase.call(courseDTOMock), completes);
    });

    test('Should return void after deleting a CourseEntity ...', () async {
      // Arrange

      when(() => repository.delete(courseDTOMock)).thenAnswer(
        (_) async => right(true), // Returns success
      );

      // Act
      final usecase = DeleteCourseUsecase(repository);
      final result = await usecase.call(courseDTOMock);

      // Assert
      expect(result.fold((l) => l, (r) => null), isA<void>());
    });
  });

  group('Delete Course Sad Path :[', () {
    test('Should complete the call even with id = -1 ...', () async {
      // Arrange

      when(() => repository.delete(courseDtoEmptyMock)).thenAnswer(
        (_) async => left(
          const CourseException(
            message: 'ERROR: The parameter is empty',
            stackTrace: StackTrace.empty,
          ),
        ),
      );

      // Act
      final usecase = DeleteCourseUsecase(repository);

      // Assert
      expect(usecase(courseDtoEmptyMock), completes);
    });

    test('Should return CourseException if id = -1 ...', () async {
      // Arrange

      when(() => repository.delete(courseDtoEmptyMock)).thenAnswer(
        (_) async => left(
          const CourseException(
            message: 'ERROR: The parameter is empty',
            stackTrace: StackTrace.empty,
          ),
        ),
      );

      // Act
      final usecase = DeleteCourseUsecase(repository);
      final result = await usecase.call(courseDtoEmptyMock);

      // Assert
      expect(result.fold((l) => l, (r) => null), isA<CourseException>());
    });
  });
}
