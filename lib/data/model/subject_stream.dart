enum SubjectStreamType { material, quiz }

class SubjectStream {
  final int id;
  final String title;
  final DateTime postedAt;
  final SubjectStreamType type;
  final int subjectId;

  SubjectStream({
    required this.id,
    required this.title,
    required this.postedAt,
    required this.type,
    required this.subjectId,
  });

  get content => null;
}