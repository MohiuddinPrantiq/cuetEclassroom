// post_view.dart

//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../data/model/comment.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/app_color.dart';

class PostView extends StatefulWidget  {
  final String postTitle;
  final String postContent;
  final DateTime postedAt;
  final String postedBy;

  PostView({
    Key? key,
    required this.postTitle,
    required this.postContent,
    required this.postedAt,
    required this.postedBy,
  }) : super(key: key);

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  // Example list of comments
  List<Comment> comments = [];

  Future<void> _fetchComments() async {
    print(123);
    final result =await FirebaseFirestore.instance.collection('notification')
        .where('title', isEqualTo: widget.postTitle).get();

    Map<String, dynamic> data=result.docs[0].data();
    var clsName=data['message'];
    List<Comment> cmts=[];
    //fetching from database
    final result1 = await FirebaseFirestore.instance.collection('comment')
        .where('class_name', isEqualTo: clsName).get();

    for (var cmnt in result1.docs) {
      //logic for finding teach name using id
      Map<String, dynamic> data1=cmnt.data();
      String u_name = data1['user_name'];
      String msg=data1['message'];
      Timestamp time=data1['postedAt'];

      //adding in subjects list
      cmts.add(
          Comment(
            class_name: clsName,
            user_name: u_name,
            message: msg,
            postedAt: time,
          )
      );
      print(cmts.length);
    }

    setState(() {
      comments=cmts;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchComments();
  }

  @override
  Widget build(BuildContext context) {
    final addComment=TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
                  'Post Details',
                  style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent, // Set the background color to transparent
        elevation: 0, // Remove the shadow
       //brightness: Brightness.dark, // Set brightness to dark for white text
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // User avatar and post information
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  // Add user avatar here
                  backgroundImage: AssetImage('assets/images/user.png'),
                  backgroundColor: Colors.grey, // Placeholder color
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.postedBy, // Replace with actual username
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      widget.postedAt.toString(), // Replace with actual timestamp
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Default content with larger box
            Container(
              margin: const EdgeInsets.only(bottom: 25),
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text(
                    widget.postTitle,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.postContent,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: addComment,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              style: const TextStyle(
                color: AppColor.white,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: "Add class comment",
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
            // Add Comment button

            ElevatedButton.icon(

              onPressed: () async {
                //print(addComment.text);
                final result =await FirebaseFirestore.instance.collection('notification')
                    .where('title', isEqualTo: widget.postTitle).get();

                Map<String, dynamic> data=result.docs[0].data();
                var clsName=data['message'];
                //print(clsName);
                final user=FirebaseAuth.instance.currentUser;
                String? u_id;
                if(user?.uid!=null)u_id=user?.uid;
                final result1 =await FirebaseFirestore.instance.collection('users').doc(u_id).get();
                var u_name=result1['name'];
                //print(u_id);
                CollectionReference collRef=FirebaseFirestore.instance.collection("comment");
                collRef.add({
                  'class_name': clsName,
                  'user_name': u_name,
                  'message': addComment.text,
                  'postedAt': Timestamp.fromDate(DateTime.now()),
                });
                for (var cmt in comments){
                  print(cmt.message);
                }
                //Navigator.of(context).pop();
              },
              icon: Icon(Icons.comment),
              label: Text('Add Comment'),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                onPrimary: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            // Comments section
            Text(
              'Comments',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            // Display comments in box-wise format
            Column(
             // _fetchComments(),
              children: comments.map((comment) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        // Add user avatar for each comment
                        backgroundColor: Colors.grey, // Placeholder color
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            comment.user_name, // Replace with actual username
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            comment.postedAt.toDate().toString(),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            comment.message,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
