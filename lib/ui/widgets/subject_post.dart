import 'package:flutter/material.dart';
import '../theme/app_color.dart';

class SubjectPost extends StatelessWidget {
  const SubjectPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(360),
            child: Image.asset(
              "assets/images/user.png",
              width: 36,
              height: 36,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              style: const TextStyle(
                color: AppColor.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: "Share something with your class",
                hintStyle: TextStyle(
                  color: AppColor.grey.withOpacity(0.5),
                  fontSize: 12,
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}