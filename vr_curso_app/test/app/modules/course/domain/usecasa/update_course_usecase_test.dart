import 'package:flutter_test/flutter_test.dart';


import 'package:mocktail/mocktail.dart';
import 'package:vr_curso_app/app/core/types/either.dart';
import 'package:vr_curso_app/app/modules/course/domain/entities/cuorse_entity.dart';
import 'package:vr_curso_app/app/modules/course/domain/repositories/i_course_repository.dart';
import 'package:vr_curso_app/app/modules/course/domain/usecasa/update_course_usecase.dart';

import 'package:vr_curso_app/app/modules/course/exception/course_exception.dart';

import '../../../../mocks/mocks.dart';

class CourseRepositoryMock extends Mock implements ICourseRepository {}

void main() {
  late ICourseRepository repository;
  late UpdateCourseUsecase usecase;

  setUp(() {
    repository = CourseRepositoryMock();
    usecase = UpdateCourseUsecase(repository);
  });

  group('Update Course Happy Path ;]', () {
    test('Should complete the call to update a CourseEntity ...', () async {
      // Arrange
      when(() => repository.update(courseDTOMock)).thenAnswer(
        (_) async => right(courseEntityMock), // Returning the correct type
      );

      // Act & Assert
      expect(
        usecase.call(courseDTOMock),
        completes,
      );
    });

    test('Should return updated CourseEntity correctly ...', () async {
      // Arrange
      when(() => repository.update(courseDTOMock)).thenAnswer(
        (_) async => right(courseEntityMock), // Returning the correct type
      );

      // Act
      final result = await usecase.call(courseDTOMock);

      // Assert
      expect(result.fold((l) => l, (r) => r), isA<CourseEntity>());
    });
  });

  group('Update Course Sad Path :[', () {
    test('Should return error if the name or ID is empty ...', () async {
      // Arrange

      when(() => repository.update(courseDTOMock)).thenAnswer(
        (_) async => left(
          const CourseException(
            message: 'ERROR: name is empty',
            stackTrace: StackTrace.empty,
          ),
        ),
      );

      // Act & Assert
      expect(
        usecase.call(courseDTOMock),
        completes,
      );
    });

    test('Should return CourseException if the name is empty ...', () async {
      // Arrange

      when(() => repository.update(courseDTOMock)).thenAnswer(
        (_) async => left(
          const CourseException(
            message: 'ERROR: name is empty',
            stackTrace: StackTrace.empty,
          ),
        ),
      );

      // Act
      final result = await usecase.call(courseDTOMock);

      // Assert
      expect(result.fold((l) => l, (r) => null), isA<CourseException>());
    });
  });
}
