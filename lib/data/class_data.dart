import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'model/student.dart';
import 'model/subject_assignment.dart';
import 'model/subject_stream.dart';
import 'model/subject.dart';

List<Student> students =[];
Future<void> student_list(Subject subject) async {
  List<Student> sts=[];
  //fetching from database
  final result = await FirebaseFirestore.instance.collection('classroom')
      .where('class_name', isEqualTo: subject.name).get();

  Map<String, dynamic> data=result.docs[0].data();


  var cnt=1;
  for (var st_id in data['student']) {
    //logic for finding teach name using id
    final ref_student = await FirebaseFirestore.instance.collection('users').doc(st_id).get();
    Map<String, dynamic> student = ref_student.data()!;
    String student_name = student['name'];
    String email=student['email'];

    //adding in subjects list
    sts.add(
        Student(
            id: cnt,
            name: student_name,
            email: email,
            avatar: "assets/images/user.png",
        )
    );
    cnt++;
  }
  students=sts;
}

final List<SubjectStream> streams = [];
Future<void> stream_list(Subject subject) async {

  print(subject.name);
  //fetching from database
  final result = await FirebaseFirestore.instance.collection('stream')
      .where('class_name', isEqualTo: subject.name).get();

  var Title, type,cnt=1;
  for (var queryDocumentSnapshot in result.docs) {
    Map<String, dynamic> data = queryDocumentSnapshot.data();
    Title = data['title'];
    //type = data['type'];
    print(Title);

    //adding in subjects list
    streams.add(
        SubjectStream(
          id: cnt,
          title: Title,
          postedAt: DateTime.now().subtract(const Duration(days: 5)),
          type: SubjectStreamType.material,
          //type:type,
          subjectId: 1,
        )
    );
    cnt++;
  }
}

/*final List<SubjectStream> streams = [
  SubjectStream(
    id: 1,
    title: "2D Sprite",
    postedAt: DateTime.now().subtract(const Duration(days: 5)),
    type: SubjectStreamType.material,
    subjectId: 1,
  ),
  SubjectStream(
    id: 2,
    title: "Image Manipulation",
    postedAt: DateTime.now().subtract(const Duration(days: 3)),
    type: SubjectStreamType.quiz,
    subjectId: 1,
  ),
  SubjectStream(
    id: 3,
    title: "Image Manipulation",
    postedAt: DateTime.now().subtract(const Duration(days: 8)),
    type: SubjectStreamType.material,
    subjectId: 1,
  ),
  SubjectStream(
    id: 4,
    title: "Colors & Shadow",
    postedAt: DateTime.now().subtract(const Duration(days: 7)),
    type: SubjectStreamType.material,
    subjectId: 1,
  ),
  SubjectStream(
    id: 5,
    title: "TCP/IP Analysis",
    postedAt: DateTime.now().subtract(const Duration(days: 4)),
    type: SubjectStreamType.quiz,
    subjectId: 2,
  ),
  SubjectStream(
    id: 6,
    title: "Wireshark",
    postedAt: DateTime.now().subtract(const Duration(days: 6)),
    type: SubjectStreamType.material,
    subjectId: 2,
  ),
  SubjectStream(
    id: 7,
    title: "DDOS",
    postedAt: DateTime.now().subtract(const Duration(days: 2)),
    type: SubjectStreamType.material,
    subjectId: 2,
  ),
  SubjectStream(
    id: 8,
    title: "Fintech",
    postedAt: DateTime.now().subtract(const Duration(days: 3)),
    type: SubjectStreamType.material,
    subjectId: 3,
  ),
  SubjectStream(
    id: 9,
    title: "Project Budgetting",
    postedAt: DateTime.now().subtract(const Duration(days: 4)),
    type: SubjectStreamType.quiz,
    subjectId: 3,
  ),
  SubjectStream(
    id: 10,
    title: "Project Budgetting",
    postedAt: DateTime.now().subtract(const Duration(days: 6)),
    type: SubjectStreamType.material,
    subjectId: 3,
  ),
  SubjectStream(
    id: 11,
    title: "Intent",
    postedAt: DateTime.now().subtract(const Duration(days: 4)),
    type: SubjectStreamType.material,
    subjectId: 4,
  ),
  SubjectStream(
    id: 12,
    title: "Data Class",
    postedAt: DateTime.now().subtract(const Duration(days: 2)),
    type: SubjectStreamType.quiz,
    subjectId: 4,
  ),
  SubjectStream(
    id: 13,
    title: "Parcelable",
    postedAt: DateTime.now().subtract(const Duration(days: 5)),
    type: SubjectStreamType.quiz,
    subjectId: 4,
  ),
];*/

final List<SubjectAssignment> assignments = [
  SubjectAssignment(
    id: 1,
    title: "2D Sprite",
    description:
    "Make a 2D sprite character using Image Manipulation tools (Photoshop, Illustrator, or else)",
    postedAt: DateTime.now().subtract(const Duration(days: 3)),
    dueAt: DateTime.now().add(const Duration(days: 5)),
    subjectId: '1',
    type: SubjectAssignmentType.turnedIn,
  ),
  SubjectAssignment(
    id: 2,
    title: "Colors & Shadow",
    description: "Implement color & shadow theory",
    postedAt: DateTime.now().subtract(const Duration(days: 4)),
    dueAt: DateTime.now().add(const Duration(days: 9)),
    subjectId: '1',
    type: SubjectAssignmentType.missing,
  ),
  SubjectAssignment(
    id: 3,
    title: "DDOS",
    description: "Analyze DDOS attack on attached study case",
    postedAt: DateTime.now().subtract(const Duration(days: 1)),
    dueAt: DateTime.now().add(const Duration(days: 4)),
    subjectId: '2',
    type: SubjectAssignmentType.missing,
  ),
  SubjectAssignment(
    id: 4,
    title: "Project Budgetting",
    description: "Analyze attached Project Budgetting as a study case",
    postedAt: DateTime.now().subtract(const Duration(days: 3)),
    dueAt: DateTime.now().add(const Duration(days: 10)),
    subjectId: '3',
    type: SubjectAssignmentType.turnedIn,
  ),
  SubjectAssignment(
    id: 5,
    title: "Fintech",
    description: "Make a report of trending Fintech product in your country",
    postedAt: DateTime.now().subtract(const Duration(days: 2)),
    dueAt: DateTime.now().add(const Duration(days: 8)),
    subjectId: '3',
    type: SubjectAssignmentType.missing,
  ),
  SubjectAssignment(
    id: 6,
    title: "Parcelable",
    description:
    "Implement Parcelable as data that being passed to another Activty",
    postedAt: DateTime.now().subtract(const Duration(days: 2)),
    dueAt: DateTime.now().add(const Duration(days: 15)),
    subjectId: '4',
    type: SubjectAssignmentType.turnedIn,
  ),
  SubjectAssignment(
    id: 7,
    title: "Data Class",
    description: "Implement data class in the current project",
    postedAt: DateTime.now().subtract(const Duration(days: 1)),
    dueAt: DateTime.now().add(const Duration(days: 4)),
    subjectId: '4',
    type: SubjectAssignmentType.turnedIn,
  ),
];