//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'model/subject.dart';
import '../ui/theme/app_color.dart';

final List<Subject> subjects = [];
void enrolled_class() async {
  subjects.clear();
  //finding current students enrolled classes
  final user=FirebaseAuth.instance.currentUser;
  String? u_id;
  if(user?.uid!=null)u_id=user?.uid;
  //print(u_id);
  
  //fetching from database
  final result = await FirebaseFirestore.instance.collection('classroom')
      .where('student', arrayContains: u_id).get();
  
  var c_name, teacher_id,cnt=1;
  for (var queryDocumentSnapshot in result.docs) {
    Map<String, dynamic> data = queryDocumentSnapshot.data();
    c_name = data['class_name'];
    teacher_id = data['teacher_id'];

    //logic for finding teach name using id
    final ref_teacher = await FirebaseFirestore.instance.collection('users').doc(teacher_id).get();
    Map<String, dynamic> teacher = ref_teacher.data()!;
    String teacher_name = teacher['name'];

    //adding in subjects list
    subjects.add(
        Subject(
            id: cnt,
            slug: c_name,
            name: c_name,
            desc:"Become a proficient Digital Artist",
            lecturer: teacher_name,
            image: "assets/images/digital_arts.png",
            gradient: [AppColor.purpleGradientStart,
              AppColor.purpleGradientEnd]
        )
    );
    cnt++;
    //print(c_name);
    //print(teacher_name);
  }
  print(subjects.length);
}

  // subjects = [
  //   Subject(
  //     id: 1,
  //     slug: "digital-arts",
  //     name: "Digital Arts",
  //     desc: "Become a proficient Digital Artist",
  //     lecturer: "Prof. Josh Kurtman",
  //     image: "assets/images/digital_arts.png",
  //     gradient: [AppColor.purpleGradientStart, AppColor.purpleGradientEnd],
  //   ),
  //   Subject(
  //     id: 2,
  //     slug: "network-security",
  //     name: "Network Security",
  //     desc: "Securing network, securing the world",
  //     lecturer: "Prof. Yelena Karpov",
  //     image: "assets/images/network_security.png",
  //     gradient: [AppColor.cyanGradientStart, AppColor.cyanGradientEnd],
  //   ),
  //   Subject(
  //     id: 3,
  //     slug: "finance",
  //     name: "Finance",
  //     desc: "Let's achieve financial freedom!",
  //     lecturer: "Maria Inge",
  //     image: "assets/images/finance.png",
  //     gradient: [AppColor.orangeGradientStart, AppColor.orangeGradientEnd],
  //   ),
  //   Subject(
  //     id: 4,
  //     slug: "mobile-dev",
  //     name: "Mobile Dev",
  //     desc: "Develop miracle within your grip",
  //     lecturer: "Prof. Jorgen Faucsh",
  //     image: "assets/images/mobile_dev.png",
  //     gradient: [AppColor.pinkGradientStart, AppColor.pinkGradientEnd],
  //   ),
  // ];