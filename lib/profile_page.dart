import 'package:cuet/login_page.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget{
  final Map<String, dynamic> userData;
  const ProfilePage({Key? key, required this.userData}) : super(key: key);
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  late Map<String, dynamic> profileData;

  @override
  void initState() {
    super.initState();
    profileData = widget.userData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(

            children: [
              Container(
                padding: EdgeInsets.only(top:60.0),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        // Profile picture
                        CircleAvatar(
                          radius: 80,
                          backgroundImage: AssetImage('assets/images/defaultUser.png'),
                        ),
                        // Ring around the profile picture
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white, // Set the color of the ring
                              width: 6, // Set the width of the ring
                            ),
                          ),
                          padding: EdgeInsets.all(5), // Adjust padding as needed
                          child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.transparent, // Make the inner circle transparent
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      profileData["name"], // Replace with the actual name
                      style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child:Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color.fromRGBO(143, 148, 251, 1)),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(143, 148, 251, .2),
                            blurRadius: 20.0,
                            offset: Offset(0, 10)
                        )
                      ]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color:  Color.fromRGBO(143, 148, 251, 1)),)
                        ),
                        child: Text(
                          profileData["type"] == "student" ? "Student ID : ${profileData["sid"]}" : "Designation : ${profileData["designation"]}",
                          style: TextStyle(color: Colors.white, fontSize: 22),

                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color:  Color.fromRGBO(143, 148, 251, 1)))
                        ),
                        child: Text(
                          profileData["type"] == "student" ? "Phone : ${profileData["phone"]}" : "Department : ${profileData["department"]}",

                          style: TextStyle(color: Colors.white, fontSize: 22),

                        ),
                      ),

                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color:  Color.fromRGBO(143, 148, 251, 1)))
                        ),
                        child: Text(
                          profileData["type"] == "student" ? "Hall : ${profileData["hall"]}" : "phone : ${profileData["phone"]}",

                          style: TextStyle(color: Colors.white, fontSize: 22),

                        ),
                      ),

                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Email : ${profileData["email"]}", // Replace with your email address
                          style: TextStyle(color: Colors.white, fontSize: 22),

                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              profileData["type"] == "student" ? Container(
                padding: EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color:  Color.fromRGBO(255, 255, 255, 1),width: 2))
                ),
                child: Text(
                  "Term-wise CGPA",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,

                  ),
                ),
              ) : SizedBox(height: 0.1),
              SizedBox(height: 10),
              profileData["type"] == "student" ? Padding(
                padding: EdgeInsets.all(10),
                child:Container(
                  width: double.infinity,
                  height: 350,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color.fromRGBO(143, 148, 251, 1)),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(143, 148, 251, .2),
                            blurRadius: 20.0,
                            offset: Offset(0, 10)
                        )
                      ]
                  ),
                ),
              ) : SizedBox(height: 0.1),
              SizedBox(height: 15),

              Padding(
                padding: EdgeInsets.all(10),
                child:Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size.fromHeight(50),
                      backgroundColor: Color.fromRGBO(143, 148, 251, 1),// Adjust the height as needed
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0), // Set border radius
                      ),
                    ),
                    onPressed: _handleLogout, // apply logout functionality

                    child: Text(
                      'Signout',
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 15),
            ],

          ),
        )

    );
  }

  void _handleLogout() async{
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()), // Replace LoginPage with your actual login page
    );
    print('signout done');
  }
}