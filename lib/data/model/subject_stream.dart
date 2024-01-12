enum SubjectStreamType { material, attendance }

class SubjectStream {

  final String title;
  final DateTime postedAt;
  final SubjectStreamType type;
  final String subjectDescription;
  final String postedBy;

  SubjectStream({

    required this.title,
    required this.postedAt,
    required this.type,
    required this.subjectDescription,
    required this.postedBy,
  });

  get content => null;
}