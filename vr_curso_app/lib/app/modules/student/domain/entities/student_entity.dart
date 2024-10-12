class StudentEntity {
  final int id;
  final String name;
  final List<int> enrollmentIds; // List of Matricula IDs

  StudentEntity({
    required this.id,
    required this.name,
    this.enrollmentIds = const [],
  });
}
