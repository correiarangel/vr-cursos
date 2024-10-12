abstract class IStudentException implements Exception {
  final String message;
  final StackTrace? stackTrace;
  const IStudentException({required this.message, required this.stackTrace});
}

class StudentException extends IStudentException {
  const StudentException({
    required super.message,
    required super.stackTrace,
  });
}

