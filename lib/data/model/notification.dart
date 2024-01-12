import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationItem {
  final String title;
  final String message;
  final Timestamp time;

  NotificationItem({
    required this.title,
    required this.message,
    required this.time,
  });
}
