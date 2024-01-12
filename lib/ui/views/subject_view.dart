import 'package:cuet/data/home_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../announcement_page.dart';
import '../../attendance_page.dart';
import '../../data/class_data.dart';
import '../../data/model/subject.dart';
import '../../data/model/subject_assignment.dart';
import '../../data/model/subject_stream.dart';
import '../theme/app_color.dart';
import '../widgets/app_icon_buttton.dart';
import '../widgets/assignment_highlight.dart';
import '../widgets/assignment_item.dart';
import '../widgets/stream_item.dart';
import '../widgets/student_item.dart';
import '../widgets/subject_post.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubjectView extends StatefulWidget {
  final Subject subject;

  const SubjectView({Key? key, required this.subject}) : super(key: key);

  @override
  State<SubjectView> createState() => _SubjectViewState();
}

class _SubjectViewState extends State<SubjectView> {
  int _activeIndex = 0;


  List<SubjectStream> allStreamList = [];
  List<SubjectAssignment> allAssignment = [];
  String userType='student';

  @override
  Future<void> _fetchStreams() async {
    try {
      List<SubjectStream> streamsData = [];
      print(widget.subject.name);
      //fetching from database
      final ref_class = await FirebaseFirestore.instance.collection('classroom')
          .where('class_name', isEqualTo: widget.subject.name).limit(1).get();
      List<dynamic> materials = ref_class.docs[0]['material'] as List<dynamic>;
      for (String materialId in materials) {
        DocumentSnapshot<Map<String, dynamic>> materialSnapshot =
        await FirebaseFirestore.instance.collection('Material')
            .doc(materialId)
            .get();
        if (materialSnapshot.exists) {

          Map<String, dynamic> materialData = materialSnapshot.data()!;
          DateTime dateTime = materialData['posted'].toDate();
          streamsData.add(
              SubjectStream(
                title: materialData['title'],
                postedAt: dateTime,
                type: materialData['title']=="Today's Attendence"?SubjectStreamType.attendance:SubjectStreamType.material,
                //type:type,
                subjectDescription: materialData['description'],
                postedBy: materialData['postedBy'],
              )
          );

        } else {
          print('Material document with ID  not found');
        }
      }
      setState(() {
        allStreamList = streamsData;
      });
      //allStreamList=streamsData;
      print('yes-found');
      print(allStreamList.length);
    } catch (error) {
      print('Error fetching enrolled classes: $error');
    }
  }

  Future<void> _fetchAssignment() async {
    try {
      List<SubjectAssignment> assignmentData = [];
      print(widget.subject.name);
      //fetching from database
      final ref_class = await FirebaseFirestore.instance.collection('classroom')
          .where('class_name', isEqualTo: widget.subject.name).limit(1).get();
      List<dynamic> assignments = ref_class.docs[0]['assignment'] as List<dynamic>;
      for (String assignmentsId in assignments) {
        DocumentSnapshot<Map<String, dynamic>> assignmentsSnapshot =
        await FirebaseFirestore.instance.collection('assignment')
            .doc(assignmentsId)
            .get();
        if (assignmentsSnapshot.exists) {

          Map<String, dynamic> assignmentsData = assignmentsSnapshot.data()!;
          DateTime dateTimepost = assignmentsData['posted'].toDate();
          DateTime dateTimedue = assignmentsData['due'].toDate();
          assignmentData.add(
              SubjectAssignment(
                  id: 1,
                  title: assignmentsData['title'],
                  description: assignmentsData['description'],
                  postedAt: dateTimepost,
                  dueAt: dateTimedue,
                  subjectId: assignmentsData['subject'],
                  type: SubjectAssignmentType.missing
              )
          );

        } else {
          print('Material document with ID  not found');
        }
      }
      setState(() {
        allAssignment = assignmentData;
      });
      //allStreamList=streamsData;
      print('yes-found');
      print(allAssignment.length);
    } catch (error) {
      print('Error fetching enrolled classes: $error');
    }
  }

  void forTeacher() async{
    User? user = FirebaseAuth.instance.currentUser;
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user?.uid)
          .get();
      Map<String, dynamic> userData =
      userDoc.data() as Map<String, dynamic>;
      userType = userData['type'];
      setState(() {

      });
    } catch(ex) {
      print('error{$ex}');
    }
  }

  void initState() {
    super.initState();
    _fetchStreams();
    _fetchAssignment();
    forTeacher();
  }

  @override
  Widget build(BuildContext context) {
    student_list(widget.subject);
    stream_list(widget.subject);
    final pageController = PageController();


    final List<Map<String, dynamic>> menus = [
      {'index': 1, 'icon': Icons.timer, 'title': "Stream"},
      {'index': 2, 'icon': Icons.assignment, 'title': "Assignment"},
      {'index': 3, 'icon': Icons.group, 'title': "Classmates"},
    ];
    final List<Widget> bodies = [
      StreamBody(streams: allStreamList),
      AssignmentBody(assignments: allAssignment),
      const ClassmateBody()
    ];


    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Announcement_page(subject: widget.subject,)),
            );
          },
          tooltip: 'Create Post',
          child: Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  AppIconButton(
                    icon: SvgPicture.asset(
                      "assets/icons/back.svg",
                      width: 24,
                      height: 24,
                      color: AppColor.white,
                    ),
                    onTap: () {
                      // Navigate back
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.subject.name,
                          style: const TextStyle(
                            color: AppColor.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.subject.desc,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColor.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppIconButton(
                        icon: SvgPicture.asset(
                          "assets/icons/gmeet.svg",
                          width: 24,
                          height: 24,
                          color: AppColor.white,
                        ),
                        onTap: () {},
                      ),
                      const SizedBox(width: 8),
                      AppIconButton(
                        icon: SvgPicture.asset(
                          "assets/icons/info.svg",
                          width: 24,
                          height: 24,
                          color: AppColor.white,
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              userType=='teacher'? Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size.fromHeight(50),
                      backgroundColor: AppColor.purpleGradientStart// Adjust the height as needed
                  ),
                  onPressed: () {
                    // Navigate to the destination page when the button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Attendance(subject: widget.subject)),
                    );
                  },
                  child: Text(
                    'Take Attendance',
                    style: TextStyle(fontSize: 20,color: Colors.white),
                  ),
                ),
              ):SizedBox(height: 0.5) ,
              const SizedBox(height: 20),
              // Assignment highlight
              Row(
                children: assignments
                    .where((item) => item.subjectId == widget.subject.id)
                    .take(2)
                    .map(
                      (item) => Expanded(
                    child: AssignmentHighlight(
                      assignment: item,
                      onTap: (item) {},
                    ),
                  ),
                )
                    .toList(),
              ),
              const SizedBox(height: 32),
              // Menu
              GNav(
                selectedIndex: _activeIndex,
                curve: Curves.easeInOutQuint,
                duration: const Duration(milliseconds: 300),
                haptic: true,
                gap: 8,
                tabMargin: const EdgeInsets.symmetric(horizontal: 8),
                color: AppColor.grey,
                activeColor: Theme.of(context).primaryColor,
                tabBackgroundColor:
                Theme.of(context).primaryColor.withOpacity(0.25),
                onTabChange: (index) {
                  setState(() {
                    _activeIndex = index;

                    pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOutQuint,
                    );
                  });
                },
                tabs: menus
                    .map(
                      (menu) => GButton(
                    gap: 8,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    icon: menu['icon'],
                    text: menu['title'],
                    textStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
                    .toList(),
              ),
              const SizedBox(height: 16),
              // Post
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      _activeIndex = index;
                    });
                  },
                  itemCount: bodies.length,
                  itemBuilder: (ctx, index) => bodies[index],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StreamBody extends StatelessWidget {
  final List<SubjectStream> streams;

  const StreamBody({Key? key, required this.streams}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        const SubjectPost(),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: streams.length,
            itemBuilder: (ctx, index) {
              final stream = streams[index];
              // Stream item
              print(456);
              return StreamItem(stream: stream);
            },
          ),
        ),
      ],
    );
  }
}

class AssignmentBody extends StatelessWidget {
  final List<SubjectAssignment> assignments;

  const AssignmentBody({Key? key, required this.assignments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SubjectPost(),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: assignments.length,
            itemBuilder: (ctx, index) {
              final assignment = assignments[index];

              return AssignmentItem(
                assignment: assignment,
              );
            },
          ),
        ),
      ],
    );
  }
}

class ClassmateBody extends StatelessWidget {
  const ClassmateBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: students.length,
            itemBuilder: (ctx, index) {
              final student = students[index];

              return StudentItem(student: student);
            },
          ),
        ),
      ],
    );
  }
}