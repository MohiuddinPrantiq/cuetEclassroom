
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'announcement_page.dart';
import 'login_page.dart';
import 'signup_page.dart';
import 'attendance_page.dart';
import 'profile_page.dart';

import 'ui/theme/app_color.dart';
import 'ui/views/home_view.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAxl6ZJ6db5qiM01kqgmj4oOPn6Zirfkk8",
      appId: "1:424374615701:android:7c9d08de484baae8dca59c",
      messagingSenderId: "424374615701",
      projectId: "cuet-e-classroom",
    ),
  );
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
      home:  (FirebaseAuth.instance.currentUser != null) ? HomeView() : LoginPage() ,
    );
  }
}

