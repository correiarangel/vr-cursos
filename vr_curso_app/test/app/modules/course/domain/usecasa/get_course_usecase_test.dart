import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:vr_curso_app/app/core/types/either.dart';
import 'package:vr_curso_app/app/modules/course/domain/entities/cuorse_entity.dart';
import 'package:vr_curso_app/app/modules/course/domain/repositories/i_course_repository.dart';
import 'package:vr_curso_app/app/modules/course/domain/usecasa/get_course_usecase.dart';
import 'package:vr_curso_app/app/modules/course/exception/course_exception.dart';

import '../../../../mocks/mocks.dart';


class CourseRepositoryMock extends Mock implements ICourseRepository {}

void main() {
  late ICourseRepository repository;

  setUp(() {
    repository = CourseRepositoryMock();
  });

  group('Get Course Happy Path :]', () {
    test('Should complete the call to get a CourseEntity ...', () async {
      // Arrange
      when(() => repository.get(courseDTOMock)).thenAnswer(
        (_) async => right(courseEmptyMock),
      );

      final usecase = GetCourseUsecase(repository);

      // Act & Assert
      expect(usecase(courseDTOMock), completes);
    });

    test('Should return a CourseEntity ...', () async {
      // Arrange
      when(() => repository.get(courseDTOMock)).thenAnswer(
        (_) async => right(courseDTOMock.entity),
      );

      final usecase = GetCourseUsecase(repository);

      // Act
      final result = await usecase(courseDTOMock);

      // Assert
      expect(result.fold((l) => l, (r) => r), isA<CourseEntity>());
    });
  });

  group('Get Course Sad Path :[', () {
    test('Should complete the call even with an empty id ...', () async {
      // Arrange
      when(() => repository.get(courseDTOMock)).thenAnswer(
        (_) async => left(
          const CourseException(
            message: 'ERROR: The parameter is empty',
            stackTrace: null,
          ),
        ),
      );

      final usecase = GetCourseUsecase(repository);

      // Act & Assert
      expect(usecase(courseDTOMock), completes);
    });

    test('Should return CourseException in case of error with empty id ...',
        () async {
      // Arrange
      when(() => repository.get(courseDTOMock)).thenAnswer(
        (_) async => left(
          const CourseException(
            message: 'ERROR: The parameter is empty',
            stackTrace: null,
          ),
        ),
      );

      final usecase = GetCourseUsecase(repository);

      // Act
      final result = await usecase(courseDTOMock);

      // Assert
      expect(result.fold((l) => l, (r) => r), isA<CourseException>());
    });
  });
}
