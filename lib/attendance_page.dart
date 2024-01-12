import 'package:cuet/ui/views/subject_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'data/model/material_post.dart';
import 'data/model/subject.dart';

class Attendance extends StatefulWidget {
  final Subject subject;
  Attendance({Key? key, required this.subject}) : super(key: key);
  @override
  _AttendanceState createState() => _AttendanceState();
}

String? sub_id;
String? posterName;

class _AttendanceState extends State<Attendance> {
  List<bool> buttonStates = List.generate(200, (index) => false);

  @override
  Future<void> get_sub() async {
    try {

      //logic for finding class_id using name
      final ref_class = await FirebaseFirestore.instance.collection('classroom')
          .where('class_name', isEqualTo: widget.subject.name).limit(1).get();
      sub_id = ref_class.docs.first.id;

      User? user = FirebaseAuth.instance.currentUser;
      DocumentSnapshot userDoc = await FirebaseFirestore
            .instance
            .collection('users')
            .doc(user?.uid)
            .get();
       Map<String, dynamic> userData =
       userDoc.data() as Map<String, dynamic>;
      posterName=userData['name'];

    } catch (error) {
      print('Error fetching enrolled classes: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    get_sub();
    return Scaffold(
      backgroundColor: Color.fromRGBO(19, 24, 32, 1),
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          'Attendance',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 10,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(143, 148, 251, 1),
                Color.fromRGBO(143, 148, 251, .7),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                physics: ScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: buttonStates.length,
                itemBuilder: (context, index) {
                  int buttonValue = index + 1;
                  Color buttonColor =
                  buttonStates[index] ? Colors.red : Colors.green;

                  return InkWell(
                    onTap: () {
                      setState(() {
                        buttonStates[index] = !buttonStates[index];
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Center(
                        child: Text(
                          buttonValue.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle data submission logic here
                submitButtonStates(context);

              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(143, 148, 251, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Container(
                height: 50,
                child: Center(
                  child: Text(
                    "Proceed",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Future<void> submitButtonStates(BuildContext context) async{
    // Add logic to submit buttonStates
    print("Submitting buttonStates: $buttonStates");
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text('Confirmation',style: TextStyle(color: Colors.white),),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure to proceed?',style: TextStyle(color: Colors.white),),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel',style: TextStyle(color: Colors.white),),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Confirm',style: TextStyle(color: Colors.white),),
              onPressed: () async{
                // Add your confirm logic here
                String presentString = '';
                String absentString = '';
                for (int i = 0; i < buttonStates.length; i++) {
                  if (buttonStates[i]) {
                    // Student is present, add their ID to the presentString
                    presentString += '$i ';
                  } else {
                    // Student is absent, add their ID to the absentString
                    absentString += '$i ';
                  }
                }
                String todayAttendance = 'Present : $presentString\n\nAbsent : $absentString';

                MaterialPost post = MaterialPost(
                    id: 1,
                    title: "Today's Attendence",
                    description: todayAttendance,
                    postedAt: DateTime.now(),
                    subjectId: sub_id!,
                    postedBy: posterName!,
                );
                print(sub_id);

                //adding in material collection
                CollectionReference materialdb = FirebaseFirestore.instance.collection('Material');
                DocumentReference doc_ref = await materialdb.add({
                  "title" : post.title,
                  "description" : post.description,
                  "posted" :  post.postedAt,
                  "subject" : post.subjectId,
                  "postedBy" : post.postedBy,
                });
                List updated_post = [];
                updated_post.add(doc_ref.id);

                //updating in database
                try {
                  var refdb = await FirebaseFirestore.instance.collection('classroom');
                  await refdb.doc(sub_id).update({
                    'material' : FieldValue.arrayUnion(updated_post),
                  });
                  print('added successfully');
                } on FirebaseAuthException catch (ex){
                  print(ex.code.toString());
                }

                Navigator.of(context).pop();// Close the dialog
                Navigator.pop(context);// Close the Attendence
                Navigator.pop(context);//// Close the streamPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SubjectView(subject: widget.subject,)),
                );
              },
            ),
          ],
        );
      },
    );
  }
}