import 'package:flutter/material.dart';
import '../../data/model/subject_assignment.dart';
import '../theme/app_color.dart';

class AssignmentStatus extends StatelessWidget {
  final SubjectAssignmentType type;

  const AssignmentStatus({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(360),
          color: (type == SubjectAssignmentType.turnedIn
              ? AppColor.green
              : AppColor.red)
              .withOpacity(0.25)),
      child: Text(
        type == SubjectAssignmentType.turnedIn ? "Turned In" : "Missing",
        style: TextStyle(
          color: type == SubjectAssignmentType.turnedIn
              ? AppColor.green
              : AppColor.red,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}