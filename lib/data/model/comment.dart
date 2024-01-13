import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String class_name;
  final String message;
  final Timestamp postedAt;
  final String user_name;

  const Comment({
    required this.class_name,
    required this.message,
    required this.postedAt,
    required this.user_name,
  });
}
