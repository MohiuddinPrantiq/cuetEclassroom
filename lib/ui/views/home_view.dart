import 'dart:async';

import 'package:cuet/data/model/student.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cuet/data/home_data.dart';
import 'package:cuet/ui/theme/app_color.dart';
import '../../data/model/subject.dart';
import '../../notifications_page.dart';
import 'package:cuet/ui/views/subject_view.dart';
import 'package:cuet/ui/widgets/app_icon_buttton.dart';
import 'package:cuet/ui/widgets/assignment_week.dart';
import 'package:cuet/ui/widgets/subject_item.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cuet/profile_page.dart';

class HomeView extends StatefulWidget{
  @override
  State<HomeView> createState() => _HomeViewState();
}

String currName='none';
String currEmail='none';
String userType='none';

class _HomeViewState extends State<HomeView> {
  List search_result = [];
  final classnameController=TextEditingController();
  final classcodeController=TextEditingController();
  final joinclassController=TextEditingController();

  TextEditingController totalStdcontroller = TextEditingController();

  List<Subject> enrolledClasses = [];

  @override
  Future<void> _fetchEnrolledClasses() async {
    try {
      List<Subject> Classes = [];
      final user=FirebaseAuth.instance.currentUser;
      String? u_id;
      if(user?.uid!=null)u_id=user?.uid;
      //print(u_id);

      DocumentSnapshot userDoc = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user?.uid)
          .get();
      Map<String, dynamic> userData =
      userDoc.data() as Map<String, dynamic>;
      currEmail=userData['email'];
      currName=userData['name'];
      userType=userData['type'];

      //fetching from database

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
      setState(() {
        enrolledClasses = Classes;
      });

      print(Classes.length);
    } catch (error) {
      print('Error fetching enrolled classes: $error');
    }
  }

  void initState() {
    super.initState();
    _fetchEnrolledClasses();
  }


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        floatingActionButton: SpeedDial(
          icon: Icons.add,
          activeIcon: Icons.close,
          visible: true,
          closeManually: false,
          renderOverlay: false,
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 8.0,
          shape: CircleBorder(),
          children: userType=='teacher'?
          [
          SpeedDialChild(
            child: Icon(Icons.add),
            backgroundColor: Colors.white,
            label: 'Join Class',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              _showJoinClassModal(context);
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.add),
            backgroundColor: Colors.white,
            label: 'Create Class',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              _showCreateClassModal(context);
            },
          ),
          ]:[
            SpeedDialChild(
              child: Icon(Icons.add),
              backgroundColor: Colors.white,
              label: 'Join Class',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () {
                _showJoinClassModal(context);
              },
            ),
          ]
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Clickable icon
                    AppIconButton(
                      icon: SvgPicture.asset(
                        "assets/icons/schedule.svg",
                        width: 24,
                        height: 24,
                        color: AppColor.white,
                      ),
                      onTap: () {},
                    ),
                    const SizedBox(width: 12),
                    AppIconButton(
                      icon: Stack(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/notification-fill.svg",
                            width: 24,
                            height: 24,
                            color: AppColor.white,
                          ),
                          Positioned(
                            right: 2,
                            top: 0,
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                                border: Border.all(
                                  color: Theme
                                      .of(context)
                                      .canvasColor,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(360),
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotificationsPage()),
                        );
                      },
                    ),
                    const SizedBox(width: 12),
                    InkWell(
                      onTap: () async {
                        print('profile tapped');

                        User? user = FirebaseAuth.instance.currentUser;
                        try {
                          DocumentSnapshot userDoc = await FirebaseFirestore
                              .instance
                              .collection('users')
                              .doc(user?.uid)
                              .get();
                          Map<String, dynamic> userData =
                          userDoc.data() as Map<String, dynamic>;

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProfilePage(userData: userData)),
                          );
                        } on FirebaseAuthException catch (ex) {
                          print(ex.code.toString());
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(360),
                        child: Image.asset(
                          "assets/images/user.png",
                          width: 32,
                          height: 32,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 24,
                          color: AppColor.white,
                        ),
                        children: [
                          TextSpan(
                            text: "CUET ",
                            style: TextStyle(
                              color: AppColor.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: "E-Classroom ",
                            style: TextStyle(
                              color: AppColor.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.6,
                      child: const Text(
                        "Never underestimate yourself, you've come this far",
                        style: TextStyle(
                          color: AppColor.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "This week",
                        style: TextStyle(
                          color: AppColor.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(360),
                        splashColor:
                        Theme
                            .of(context)
                            .primaryColor
                            .withOpacity(0.25),
                        highlightColor:
                        Theme
                            .of(context)
                            .primaryColor
                            .withOpacity(0.4),
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            "View all",
                            style: TextStyle(
                              color: Theme
                                  .of(context)
                                  .primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: const [
                      Expanded(
                        child: AssignmentWeek(
                          count: 5,
                          subjects: ["Digital Arts, Finance"],
                          type: AssignmentType.assigned,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: AssignmentWeek(
                          count: 2,
                          subjects: ["Network Security, Mobile Dev"],
                          type: AssignmentType.missed,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 32),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: enrolledClasses.length,
                  itemBuilder: (ctx, index) {
                    final subject = enrolledClasses[index];
                    // Subject Item
                    return GestureDetector(
                      onTap: () {
                        // Navigate to subject view
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => SubjectView(subject: subject),
                          ),
                        );
                      },
                      child: SubjectItem(subject: subject),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _showJoinClassModal(BuildContext context) {
    StreamController<String> controller = StreamController<String>();
    Stream<String> stream = controller.stream;
    String query;
    showBarModalBottomSheet(
      context: context,
      animationCurve: Curves.easeInOut,
      backgroundColor: Theme
          .of(context)
          .canvasColor,
      bounce: true,
      enableDrag: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      builder: (ctx) =>
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 16,
            ),
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Join Class",
                    style: TextStyle(
                      color: AppColor.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: joinclassController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    style: const TextStyle(
                      color: AppColor.white,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: "Enter your class code",
                      hintStyle: TextStyle(
                        color: AppColor.grey.withOpacity(0.75),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: AppColor.dark,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Theme
                              .of(context)
                              .primaryColor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(360),
                            child: Image.asset(
                              "assets/images/user.png",
                              width: 32,
                              height: 32,
                            ),
                          ),
                          const SizedBox(width: 16),
                           Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                currName,
                                style: TextStyle(
                                  color: AppColor.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                currEmail,
                                style: TextStyle(
                                  color: AppColor.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      AppIconButton(
                        icon: Icon(
                          Icons.chevron_right,
                          color: AppColor.grey.withOpacity(0.75),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  MaterialButton(
                    minWidth: MediaQuery
                        .of(context)
                        .size
                        .width,
                    elevation: 0,
                    highlightElevation: 0,
                    splashColor:
                    Theme
                        .of(context)
                        .canvasColor
                        .withOpacity(0.15),
                    highlightColor:
                    Theme
                        .of(context)
                        .canvasColor
                        .withOpacity(0.25),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    color: Theme
                        .of(context)
                        .primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "Join Class",
                      style: TextStyle(
                        color: AppColor.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed:()  async {
                      query = joinclassController.text.trim();

                      final result = await FirebaseFirestore.instance.collection('classroom')
                          .where('class_code', isEqualTo: query)
                          .get();

                      //get Doc_id
                      String documentId = result.docs.first.id;
                      print(documentId);

                      //for storing the fetched data
                      List<Map<String, dynamic>> search_res =[];

                      setState(() {
                        search_res = result.docs.map((e) => e.data()).toList();
                      });

                      //update
                      final user=FirebaseAuth.instance.currentUser;
                      String? u_id;
                      if(user?.uid!=null)u_id=user?.uid;

                      // adding student to  the class's students
                      search_res[0]['student'].add(u_id.toString());
                      List updated_student = search_res[0]['student'];

                      print(updated_student);

                      //updating in database
                      var refdb = await FirebaseFirestore.instance.collection('classroom');
                      await refdb.doc(documentId).update({
                        'student' : FieldValue.arrayUnion(updated_student),
                      });

                      //close modal

                      _fetchEnrolledClasses();

                      Navigator.of(context).pop();
                      Navigator.pop(context);//// Close the streamPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeView()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
    );
  }

  void _showCreateClassModal(BuildContext context) {
    showBarModalBottomSheet(
      context: context,
      animationCurve: Curves.easeInOut,
      backgroundColor: Theme
          .of(context)
          .canvasColor,
      bounce: true,
      enableDrag: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      builder: (ctx) =>
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery
                  .of(context)
                  .viewInsets
                  .bottom,
            ),
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Class Name",
                    style: TextStyle(
                      color: AppColor.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: classnameController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    style: const TextStyle(
                      color: AppColor.white,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: "Enter class name",
                      hintStyle: TextStyle(
                        color: AppColor.grey.withOpacity(0.75),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: AppColor.dark,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Theme
                              .of(context)
                              .primaryColor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    "Number of Students",
                    style: TextStyle(
                      color: AppColor.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: totalStdcontroller,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    style: const TextStyle(
                      color: AppColor.white,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: "Enter total number of students",
                      hintStyle: TextStyle(
                        color: AppColor.grey.withOpacity(0.75),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: AppColor.dark,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Theme
                              .of(context)
                              .primaryColor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    "Class Code",
                    style: TextStyle(
                      color: AppColor.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: classcodeController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    style: const TextStyle(
                      color: AppColor.white,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: "Enter Class Code",
                      hintStyle: TextStyle(
                        color: AppColor.grey.withOpacity(0.75),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: AppColor.dark,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Theme
                              .of(context)
                              .primaryColor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  MaterialButton(
                    minWidth: MediaQuery
                        .of(context)
                        .size
                        .width,
                    elevation: 0,
                    highlightElevation: 0,
                    splashColor:
                    Theme
                        .of(context)
                        .canvasColor
                        .withOpacity(0.15),
                    highlightColor:
                    Theme
                        .of(context)
                        .canvasColor
                        .withOpacity(0.25),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    color: Theme
                        .of(context)
                        .primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "Create Class",
                      style: TextStyle(
                        color: AppColor.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async{
                      // Do something & close modal
                      //print(classnameController.text);
                      //print(classcodeController.text);
                      final user=FirebaseAuth.instance.currentUser;
                      String? u_id;
                      if(user?.uid!=null)u_id=user?.uid;
                      DocumentSnapshot userDoc = await FirebaseFirestore
                          .instance
                          .collection('users')
                          .doc(user?.uid)
                          .get();
                      Map<String, dynamic> userData =
                      userDoc.data() as Map<String, dynamic>;
                      userType = userData['type'];
                      String head = userData['email'];
                      String isHead = head.substring(0, 4);
                      //print(u_id);
                      CollectionReference collRef=FirebaseFirestore.instance.collection("classroom");
                      // Create a List<int> initialized with zeros for attendance
                      List<int> initialAttendance = List.filled(int.tryParse(totalStdcontroller.text) ?? 0, 0);

                      collRef.add({
                        'class_name': classnameController.text,
                        'class_code': classcodeController.text,
                        'student':[],
                        'teacher_id':u_id,
                        'NoStudents' : int.tryParse(totalStdcontroller.text),
                        'attendance': initialAttendance,
                        'head' : isHead=='head'?'head':'nothead',
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
    );
  }
}