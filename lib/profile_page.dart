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

List<Color> showColor = [
  Colors.yellow,
  Colors.lightBlue,
  Colors.orange,
  Colors.green,
  Colors.red,
  Colors.teal,
  Colors.purple,
  Colors.blue,
];

class _ProfilePageState extends State<ProfilePage> {
  late List<double> CGPA=[];
  late Map<String, dynamic> profileData;
  @override
  void fetchCPGA() async{
    try{
      String lastThreeDigits = widget.userData['sid'].substring(widget.userData['sid'].length - 3);
      print(lastThreeDigits);
      int roll=int.parse(lastThreeDigits);
      print(roll);
      final user=FirebaseAuth.instance.currentUser;
      final result1 = await FirebaseFirestore.instance.collection('classroom')
          .where('student', arrayContains: user?.uid)
          .where('head',isEqualTo: 'head').get();
      if(result1.docs.isNotEmpty){
        List<dynamic> existingCgpaList = result1.docs[0]['cgpa'] ?? [];
        print(existingCgpaList);

        for (Map<String, dynamic> cgpaMap in existingCgpaList) {
          // Iterate through the values (lists) of each map
          cgpaMap.forEach((key, value) {
            if (value is List<dynamic>) {
              CGPA.add(value[roll-1].toDouble());
            }
          });
        }
        setState(() {

        });
        print(CGPA);
      }
      else{
        print('no cgpa found');
      }
    } catch (error) {
      print('Error fetching enrolled classes: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCPGA();
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
              profileData["type"] == "student"
                  ? Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  width: double.infinity,
                  height: 350,
                  padding: EdgeInsets.all(16), // Adjust padding as needed
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color.fromRGBO(143, 148, 251, 1)),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(143, 148, 251, .2),
                        blurRadius: 20.0,
                        offset: Offset(0, 10),
                      )
                    ],
                  ),
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 4, // Adjust based on your data
                      barGroups: List.generate(
                        CGPA.length,
                            (index) => BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: CGPA[index],
                              width: 20, // Adjust the width of the bars as needed
                              color: showColor[index],
                              rodStackItems: [
                                BarChartRodStackItem(
                                  0,
                                  CGPA[index],
                                  showColor[index],
                                ),
                              ],
                            ),

                          ],
                              showingTooltipIndicators: [0]
                        ),
                      ),
                      titlesData: FlTitlesData(
                        rightTitles:  AxisTitles(

                          sideTitles: SideTitles(showTitles: false,),
                        ),

                        topTitles: AxisTitles(

                          sideTitles: SideTitles(showTitles: false,),
                        ),

                        bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                                getTitlesWidget: (data, value) {
                                  return Text(
                                    'L${((data+2)/2).toInt()}T${data%2==0?1:2}',
                                    style: const TextStyle(color: Colors.white,
                                        fontSize: 9, fontWeight: FontWeight.w500),
                                  );
                                },
                                showTitles: true,
                                reservedSize: 30)),
                        leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                                getTitlesWidget: (data, value) {
                                  return Text(
                                    data.toString(),
                                    style: const TextStyle( color: Colors.white,
                                        fontSize: 9, fontWeight: FontWeight.w500),
                                  );
                                },
                                showTitles: true,
                                reservedSize: 30)),

                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border(bottom: BorderSide(color: Colors.white),left: BorderSide(color: Colors.white)),
                      ),
                    ),
                  ),
                ),
              )
                  : SizedBox(height: 0.1),
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