abstract class ICourseException implements Exception {
  final String message;
  final StackTrace? stackTrace;
  const ICourseException({required this.message, required this.stackTrace});
}

class CourseException extends ICourseException {
  const CourseException({
    required super.message,
    required super.stackTrace,
  });
}

