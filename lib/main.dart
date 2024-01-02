import 'package:cuet/attendance_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'login_page.dart';

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
      home: const HomeView(),
    );
  }
}

