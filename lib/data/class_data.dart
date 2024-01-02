import 'model/student.dart';
import 'model/subject_assignment.dart';
import 'model/subject_stream.dart';

final List<Student> students = [
  const Student(
    id: 1,
    name: "Eko Widiatmoko",
    email: "ekowidiatmoko@gmail.com",
    avatar: "assets/images/user.png",
  ),
  const Student(
    id: 2,
    name: "Jonah Wieldbreg",
    email: "jonahwield@gmail.com",
    avatar: "assets/images/student_1.png",
  ),
  const Student(
    id: 3,
    name: "Maya Silver",
    email: "maysilv@gmail.com",
    avatar: "assets/images/student_2.png",
  ),
  const Student(
    id: 4,
    name: "Rébecca Eugenia",
    email: "eugeniareb@gmail.com",
    avatar: "assets/images/student_3.png",
  ),
  const Student(
    id: 5,
    name: "Lynsey Frona",
    email: "lynsfro@gmail.com",
    avatar: "assets/images/student_4.png",
  ),
  const Student(
    id: 6,
    name: "Lee Hayden",
    email: "leehayden@gmail.com",
    avatar: "assets/images/student_5.png",
  ),
];

final List<SubjectStream> streams = [
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
];

final List<SubjectAssignment> assignments = [
  SubjectAssignment(
    id: 1,
    title: "2D Sprite",
    description:
    "Make a 2D sprite character using Image Manipulation tools (Photoshop, Illustrator, or else)",
    postedAt: DateTime.now().subtract(const Duration(days: 3)),
    dueAt: DateTime.now().add(const Duration(days: 5)),
    subjectId: 1,
    type: SubjectAssignmentType.turnedIn,
  ),
  SubjectAssignment(
    id: 2,
    title: "Colors & Shadow",
    description: "Implement color & shadow theory",
    postedAt: DateTime.now().subtract(const Duration(days: 4)),
    dueAt: DateTime.now().add(const Duration(days: 9)),
    subjectId: 1,
    type: SubjectAssignmentType.missing,
  ),
  SubjectAssignment(
    id: 3,
    title: "DDOS",
    description: "Analyze DDOS attack on attached study case",
    postedAt: DateTime.now().subtract(const Duration(days: 1)),
    dueAt: DateTime.now().add(const Duration(days: 4)),
    subjectId: 2,
    type: SubjectAssignmentType.missing,
  ),
  SubjectAssignment(
    id: 4,
    title: "Project Budgetting",
    description: "Analyze attached Project Budgetting as a study case",
    postedAt: DateTime.now().subtract(const Duration(days: 3)),
    dueAt: DateTime.now().add(const Duration(days: 10)),
    subjectId: 3,
    type: SubjectAssignmentType.turnedIn,
  ),
  SubjectAssignment(
    id: 5,
    title: "Fintech",
    description: "Make a report of trending Fintech product in your country",
    postedAt: DateTime.now().subtract(const Duration(days: 2)),
    dueAt: DateTime.now().add(const Duration(days: 8)),
    subjectId: 3,
    type: SubjectAssignmentType.missing,
  ),
  SubjectAssignment(
    id: 6,
    title: "Parcelable",
    description:
    "Implement Parcelable as data that being passed to another Activty",
    postedAt: DateTime.now().subtract(const Duration(days: 2)),
    dueAt: DateTime.now().add(const Duration(days: 15)),
    subjectId: 4,
    type: SubjectAssignmentType.turnedIn,
  ),
  SubjectAssignment(
    id: 7,
    title: "Data Class",
    description: "Implement data class in the current project",
    postedAt: DateTime.now().subtract(const Duration(days: 1)),
    dueAt: DateTime.now().add(const Duration(days: 4)),
    subjectId: 4,
    type: SubjectAssignmentType.turnedIn,
  ),
];