import 'package:cuet/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

import 'data/model/notification.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'ui/widgets/app_icon_buttton.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NotificationsPage extends StatelessWidget {
  final List<NotificationItem> notifications = [
    NotificationItem(
      title: 'Assignment Posted',
      message: 'Math assignment for Chapter 5 is now available.',
      time: '2 hours ago',
    ),
    NotificationItem(
      title: 'New Announcement',
      message: 'There will be a parent-teacher meeting next week.',
      time: '1 day ago',
    ),
    // Add more notifications as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications',style: TextStyle(color: AppColor.white, fontWeight: FontWeight.bold),),
        backgroundColor: AppColor.black,
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(notifications[index].title,style: TextStyle(color: Colors.white)),
            subtitle: Text(notifications[index].message,style: TextStyle(color: Colors.white)),
            trailing: Text(notifications[index].time,style: TextStyle(color: Colors.white)),
            onTap: () {
              print("clicked");
              // Handle notification tap
              // You can navigate to a detailed view or perform other actions
            },
          );
        },
      ),
    );
  }
}