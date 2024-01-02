
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'announcement_page.dart';
import 'login_page.dart';
import 'signup_page.dart';
import 'attendance_page.dart';
import 'profile_page.dart';

import 'ui/theme/app_color.dart';
import 'ui/views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: AppColor.black, // Set your desired color
    ));
    return MaterialApp(
      title: 'cuetEclassroom',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: AppColor.black,
        scaffoldBackgroundColor: AppColor.black,
        fontFamily: "Inter",
      ),
      home:  HomeView(),
    );
  }
}

