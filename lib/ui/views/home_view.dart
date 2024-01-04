import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cuet/data/home_data.dart';
import 'package:cuet/ui/theme/app_color.dart';
import '../../notifications_page.dart';
import 'package:cuet/ui/views/subject_view.dart';
import 'package:cuet/ui/widgets/app_icon_buttton.dart';
import 'package:cuet/ui/widgets/assignment_week.dart';
import 'package:cuet/ui/widgets/subject_item.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cuet/profile_page.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                onPressed: () {
                  showBarModalBottomSheet(
                    context: context,
                    animationCurve: Curves.easeInOut,
                    backgroundColor: Theme.of(context).canvasColor,
                    bounce: true,
                    enableDrag: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    builder: (ctx) => Padding(
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
                                    color: Theme.of(context).primaryColor,
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
                                    const Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Eko Widiatmoko",
                                          style: TextStyle(
                                            color: AppColor.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          "ekowidiatmoko@gmail.com",
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
                              minWidth: MediaQuery.of(context).size.width,
                              elevation: 0,
                              highlightElevation: 0,
                              splashColor:
                              Theme.of(context).canvasColor.withOpacity(0.15),
                              highlightColor:
                              Theme.of(context).canvasColor.withOpacity(0.25),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                              color: Theme.of(context).primaryColor,
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
                              onPressed: () {
                                // Do something & close modal
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                backgroundColor: Theme.of(context).primaryColor,
                splashColor: AppColor.black.withOpacity(0.35),
                child: const Icon(
                  Icons.add,
                ),
                tooltip: 'Join Class',
              ),
            ),
            const SizedBox(height: 16),
            FloatingActionButton(
              onPressed: () {
                showBarModalBottomSheet(
                  context: context,
                  animationCurve: Curves.easeInOut,
                  backgroundColor: Theme.of(context).canvasColor,
                  bounce: true,
                  enableDrag: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  builder: (ctx) => Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Create Class",
                            style: TextStyle(
                              color: AppColor.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
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
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          const Text(
                            "Create Class Code",
                            style: TextStyle(
                              color: AppColor.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            style: const TextStyle(
                              color: AppColor.white,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              hintText: "Class Code",
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
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            elevation: 0,
                            highlightElevation: 0,
                            splashColor:
                            Theme.of(context).canvasColor.withOpacity(0.15),
                            highlightColor:
                            Theme.of(context).canvasColor.withOpacity(0.25),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            color: Theme.of(context).primaryColor,
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
                            onPressed: () {
                              // Do something & close modal
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              backgroundColor: Theme.of(context).primaryColor,
              splashColor: AppColor.black.withOpacity(0.35),
              child: const Icon(
                Icons.add,
              ),
              tooltip: 'Create Class',
            ),
          ],
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
                                color: Theme.of(context).primaryColor,
                                border: Border.all(
                                  color: Theme.of(context).canvasColor,
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
                            text: "Morning ",
                            style: TextStyle(
                              color: AppColor.white,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          TextSpan(
                            text: "Eko ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                              text: "👋🏼",
                              style: TextStyle(
                                fontSize: 18,
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
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
                        Theme.of(context).primaryColor.withOpacity(0.25),
                        highlightColor:
                        Theme.of(context).primaryColor.withOpacity(0.4),
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            "View all",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
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
                  itemCount: subjects.length,
                  itemBuilder: (ctx, index) {
                    final subject = subjects[index];

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
}