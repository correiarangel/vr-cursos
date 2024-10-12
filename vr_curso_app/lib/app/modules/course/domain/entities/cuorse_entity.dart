
class CourseEntity {
  final int id;
  final String description;
  final String syllabus;
  final List<int> enrollmentCodes;

  const CourseEntity({
    required this.id,
    required this.description,
    required this.syllabus,
    required this.enrollmentCodes,
  });
}
