import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vr_curso_app/app/core/types/either.dart';
import 'package:vr_curso_app/app/modules/course/domain/entities/cuorse_entity.dart';
import 'package:vr_curso_app/app/modules/course/domain/repositories/i_course_repository.dart';
import 'package:vr_curso_app/app/modules/course/domain/usecasa/get_all_course_usecase.dart';
import 'package:vr_curso_app/app/modules/course/exception/course_exception.dart';

import '../../../../mocks/mocks.dart';

const exceptionMock =
    CourseException(message: 'Error', stackTrace: StackTrace.empty);
void main() {
  late ICourseRepository repository;

  setUpAll(() {});

  setUp(() {
    repository = CourseRepositoryMock();
  });

  group('Get All Courses Happy Path :]', () {
    test('Should complete use case call', () async {
      // Arrange
      when(() => repository.getAll())
          .thenAnswer((_) async => right(courseEntityListMock));

      final usecase = GetAllCourseUsecase(repository);

      // Act & Assert
      expect(usecase(), completes);
    });

    test('Should return list of CourseEntity', () async {
      // Arrange
      when(() => repository.getAll())
          .thenAnswer((_) async => right(courseEntityListMock));

      final usecase = GetAllCourseUsecase(repository);

      // Act
      final result = await usecase();

      // Assert
      expect(result.fold((l) => l, (r) => r), isA<List<CourseEntity>>());
    });
  });

  group('Get All Courses Sad Path :[', () {
    test('Should return Left in case of exception', () async {
      // Arrange
      when(() => repository.getAll())
          .thenAnswer((_) async => left(exceptionMock));

      final usecase = GetAllCourseUsecase(repository);

      // Act
      final result = await usecase();

      // Assert
      expect(result.isLeft, true);
    });

    test('Should return CourseException in case of error', () async {
      // Arrange
      when(() => repository.getAll())
          .thenAnswer((_) async => left(exceptionMock));

      final usecase = GetAllCourseUsecase(repository);

      // Act
      final result = await usecase();

      // Assert
      expect(result.fold((l) => l, (r) => r), isA<CourseException>());
    });
  });
}
