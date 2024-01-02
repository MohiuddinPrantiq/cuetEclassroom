import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../data/model/subject_assignment.dart';
import '../theme/app_color.dart';
import 'Assignment_individual.dart';
import 'assignment_status.dart';
import 'package:intl/intl.dart';


class AssignmentItem extends StatelessWidget {
  final SubjectAssignment assignment;

  const AssignmentItem({Key? key, required this.assignment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
              MaterialPageRoute(
                builder: (context) => AssignmentWidget(
                  assignment: assignment,
                ),
              ),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.dark, width: 1.3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/assignment.svg",
                          color: AppColor.white,
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                assignment.title,
                                style: const TextStyle(
                                  color: AppColor.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Due at " +
                                    DateFormat("MMM dd").format(assignment.dueAt),
                                style: const TextStyle(
                                  color: AppColor.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        AssignmentStatus(type: assignment.type),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Text(
                        assignment.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColor.grey,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                splashColor: AppColor.white.withOpacity(0.05),
                highlightColor: AppColor.white.withOpacity(0.15),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: AppColor.dark,
                      ),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/comment.svg",
                        color: AppColor.grey,
                        width: 16,
                        height: 16,
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        "Add class's comment",
                        style: TextStyle(
                          color: AppColor.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
