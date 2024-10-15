import 'package:vr_curso_app/app/modules/enrollment/exception/enrollment_exception.dart';

import '../../models/enrollment_model.dart';

abstract class EnrollmentState {}

class EnrollmentInitialState implements EnrollmentState {}

class CreateEnrollmentLoadingState implements EnrollmentState {}

class EnrollmentLoadingState implements EnrollmentState {}

class CreateEnrollmentSuccessState implements EnrollmentState {
  final EnrollmentModel enrollment;
  CreateEnrollmentSuccessState(this.enrollment);
}

class CurrentEnrollmentState implements EnrollmentState {
  final EnrollmentModel enrollment;
  CurrentEnrollmentState(this.enrollment);
}

class DeleteEnrollmentSuccessState implements EnrollmentState {}

class UpdateEnrollmentSuccessState implements EnrollmentState {
  final EnrollmentModel enrollment;
  UpdateEnrollmentSuccessState(this.enrollment);
}

class GetAllEnrollmentSuccessState implements EnrollmentState {
  final List<EnrollmentModel> enrollments;
  GetAllEnrollmentSuccessState(this.enrollments);
}

class GetEnrollmentSuccessState implements EnrollmentState {
  final EnrollmentModel enrollment;
  GetEnrollmentSuccessState(this.enrollment);
}

class EnrollmentExceptionState implements EnrollmentState {
  final EnrollmentException exception;
  EnrollmentExceptionState(this.exception);
}
