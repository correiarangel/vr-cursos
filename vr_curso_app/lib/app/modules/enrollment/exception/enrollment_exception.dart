abstract class IEnrollmentException implements Exception {
  final String message;
  final StackTrace? stackTrace;
  const IEnrollmentException({required this.message, required this.stackTrace});
}

class EnrollmentException extends IEnrollmentException {
  const EnrollmentException({
    required super.message,
    required super.stackTrace,
  });
}

