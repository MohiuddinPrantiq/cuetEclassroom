import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ProfilePage extends StatelessWidget{
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
                            color: Colors.black, // Set the color of the ring
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
                    'Mohiuddin Prantiq', // Replace with the actual name
                    style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
            Container(
              width: 350,

              padding: EdgeInsets.all(5),
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
                    width: 340,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color:  Color.fromRGBO(143, 148, 251, 1)),)
                    ),
                    child: Text(
                      "Email : u1904103@student.cuet.ac.bd", // Replace with your email address
                      style: TextStyle(color: Colors.grey[700], fontSize: 22),

                    ),
                  ),
                  Container(
                    width: 340,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color:  Color.fromRGBO(143, 148, 251, 1)))
                    ),
                    child: Text(
                      "Student ID : 1904103", // Replace with your email address
                      style: TextStyle(color: Colors.grey[700], fontSize: 22),

                    ),
                  ),


                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Phone : 01903590363", // Replace with your email address
                      style: TextStyle(color: Colors.grey[700], fontSize: 22),

                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color:  Color.fromRGBO(0, 0, 0, 1),width: 2))
              ),
              child: Text(
                "Term-wise CGPA", // Replace with your email address
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,

                ),
              ),
            ),


          ],

        ),
      )


    );
  }

}