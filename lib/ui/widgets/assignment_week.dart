import 'package:flutter/material.dart';
import '../theme/app_color.dart';

enum AssignmentType { assigned, missed }

class AssignmentWeek extends StatelessWidget {
  final int count;
  final List<String> subjects;
  final AssignmentType type;

  const AssignmentWeek(
      {Key? key,
        required this.count,
        required this.subjects,
        required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      splashColor: AppColor.white.withOpacity(0.05),
      highlightColor: AppColor.white.withOpacity(0.15),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColor.dark,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  count.toString(),
                  style: const TextStyle(
                    color: AppColor.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  type == AssignmentType.assigned ? "Assigned" : "Missed",
                  style: const TextStyle(
                    color: AppColor.white,
                  ),
                )
              ],
            ),
            const SizedBox(height: 4),
            Text(
              subjects.join(","),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColor.grey,
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }
}