class MaterialPost {
  final int id;
  final String title;
  final String description;
  final DateTime postedAt;
  final String subjectId;

  MaterialPost({
    required this.id,
    required this.title,
    required this.description,
    required this.postedAt,
    required this.subjectId,
  });
}