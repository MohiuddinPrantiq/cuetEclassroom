enum SubjectStreamType { material, quiz }

class SubjectStream {

  final String title;
  final DateTime postedAt;
  final SubjectStreamType type;
  final String subjectDescription;

  SubjectStream({

    required this.title,
    required this.postedAt,
    required this.type,
    required this.subjectDescription,
  });

  get content => null;
}