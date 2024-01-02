enum SubjectAssignmentType { turnedIn, missing }

class SubjectAssignment {
  final int id;
  final String title;
  final String description;
  final DateTime postedAt;
  final DateTime dueAt;
  final int subjectId;
  final SubjectAssignmentType type;

  SubjectAssignment({
    required this.id,
    required this.title,
    required this.description,
    required this.postedAt,
    required this.dueAt,
    required this.subjectId,
    required this.type,
  });
}