import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuet/ui/theme/app_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'data/model/notification.dart';
import 'data/model/subject.dart';


class NotificationsPage extends StatefulWidget {
  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<NotificationItem> notifications = [];

  //fetching from database
  @override
  Future<void> get_notifications() async {
    final List<NotificationItem> notification_list = [];

    //fetching classes of current user
    List<Subject> Classes = [];
    try {
      final user=FirebaseAuth.instance.currentUser;
      String? u_id;
      if(user?.uid!=null)u_id=user?.uid;
      //print(u_id);

      DocumentSnapshot userDoc = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user?.uid)
          .get();
      final result1 = await FirebaseFirestore.instance.collection('classroom')
          .where('student', arrayContains: u_id).get();
      final result2 = await FirebaseFirestore.instance.collection('classroom')
          .where('teacher_id', isEqualTo: u_id).get();
      Set<DocumentSnapshot<Map<String, dynamic>>> combinedResults = {};
      combinedResults.addAll(result1.docs);
      combinedResults.addAll(result2.docs);

      var c_name, teacher_id,cnt=1;
      int totalStd;
      for (var queryDocumentSnapshot in combinedResults) {
        Map<String, dynamic>? data = queryDocumentSnapshot.data();
        c_name = data?['class_name'];
        teacher_id = data?['teacher_id'];
        totalStd = data?['NoStudents'];
        //logic for finding teach name using id
        final ref_teacher = await FirebaseFirestore.instance.collection('users').doc(teacher_id).get();
        Map<String, dynamic> teacher = ref_teacher.data()!;
        String teacher_name = teacher['name'];

        //adding in subjects list
        Classes.add(
            Subject(
                id: cnt,
                slug: c_name,
                name: c_name,
                desc:"Become a proficient Digital Artist",
                lecturer: teacher_name,
                image: "assets/images/digital_arts.png",
                gradient: [AppColor.purpleGradientStart,
                  AppColor.purpleGradientEnd],
                totalStudent: totalStd,
            )
        );
        cnt++;
        //print(c_name);
        //print(teacher_name);
      }
      print(Classes.length);

      // fetching notification of current user
      final ref_notify = await FirebaseFirestore.instance.collection('notification').get();

      for (var queryDocumentSnapshot in ref_notify.docs) {

        Map<String, dynamic> data = queryDocumentSnapshot.data();
        for(Subject each_class in Classes) {
          if(each_class.name == data['message']) {
            notification_list.add(NotificationItem(
                title: data['title'],
                message: data['message'],
                time: data['time'])
            );
          }
        }

      }
      print(notification_list.length);
    } catch (error) {
      print('Error fetching enrolled classes: $error');
    }


    setState(() {
      notifications = notification_list;
    });
    print('Notification length ${notifications[0].title}');
  }

  @override
  void initState() {
    super.initState();
    get_notifications();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications',style: TextStyle(color: AppColor.white, fontWeight: FontWeight.bold),),
        backgroundColor: AppColor.black,
        elevation: 0,
        leading: BackButton(
          color: AppColor.white,
        ),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.purpleGradientStart),
              borderRadius: BorderRadius.circular(18.0),
            ),
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.all(10.0),
            child: ListTile(
              title: Text(
                notifications[index].title,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 19.0),
              ),
              subtitle: Text(
                'New post from ${notifications[index].message}.',
                style: TextStyle(color: Colors.white, fontSize: 15.0),
              ),
              trailing: Text(
                notifications[index].time.toDate().toString(),
                style: TextStyle(color: Colors.white, fontSize: 13.0),
              ),
              onTap: () {
                print("clicked");
                // Handle notification tap
                // You can navigate to a detailed view or perform other actions
              },
            ),
          );
        },
      ),
    );
  }
}