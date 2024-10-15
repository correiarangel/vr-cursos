import 'package:flutter/cupertino.dart';
import 'package:vr_curso_app/app/modules/enrollment/presenter/models/enrollment_model.dart';

@immutable
abstract class EnrollmentEvent {}

class EnrollmentInitialEvent extends EnrollmentEvent {}

class CreateEnrollmentEvent extends EnrollmentEvent {
  final EnrollmentModel enrollment;
  CreateEnrollmentEvent(this.enrollment);
}

class UpdateEnrollmentEvent extends EnrollmentEvent {
  final EnrollmentModel enrollment;
  UpdateEnrollmentEvent(this.enrollment);
}

class CurrentEnrollmentEvent extends EnrollmentEvent {
  final EnrollmentModel enrollment;
  CurrentEnrollmentEvent(this.enrollment);
}

class DeleteEnrollmentEvent extends EnrollmentEvent {
  final EnrollmentModel enrollment;
  DeleteEnrollmentEvent(this.enrollment);
}

class GetAllEnrollmentEvent extends EnrollmentEvent {}

class GetEnrollmentEvent extends EnrollmentEvent {
  final EnrollmentModel enrollment;
  GetEnrollmentEvent(this.enrollment);
}

class LoadingEnrollmentEvent extends EnrollmentEvent {}

class ChangedEnrollmentInitialEvent extends EnrollmentEvent {
  final EnrollmentInitialEvent state;
  ChangedEnrollmentInitialEvent({required this.state});
}
