import 'package:flutter/material.dart';
import '../../announcement_page.dart';
import '../../data/model/subject.dart';
import '../theme/app_color.dart';

class SubjectPost extends StatelessWidget {

  final Subject subject;

  const SubjectPost({Key? key, required this.subject}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap:(){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Announcement_page(subject: subject,)),
          );
        },
        child:Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.dark, width: 1.3),
            borderRadius: BorderRadius.circular(8),
          ),
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
                child: Text(
                  "Share something with your class",
                  style: TextStyle(
                    color: AppColor.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}