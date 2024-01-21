import 'package:cuet/ui/views/subject_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'data/model/material_post.dart';
import 'data/model/subject.dart';


class CGPAPage extends StatefulWidget {
  final Subject subject;
  int totalStd;
  CGPAPage({Key? key, required this.subject,required this.totalStd}) : super(key: key);
  @override
  _CGPAPageState createState() => _CGPAPageState();
}

class _CGPAPageState extends State<CGPAPage> {
  // Variables
  int rowCount = 32; // Change this based on your requirement
  List<TextEditingController> cgpaControllers = [];




  @override
  void initState() {
    super.initState();
    // Initialize controllers
    for (int i = 0; i < widget.totalStd; i++) {
      cgpaControllers.add(TextEditingController());
    }

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea( child: Scaffold(
      appBar: AppBar(
        title: Text('CGPA Page',
        style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
      child:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Rows
            for (int i = 1; i <= widget.totalStd; i++)
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin: EdgeInsets.symmetric(vertical: 8.0),
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(width: 16),
                    Container(
                      width: 100, // Adjust the width as needed
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: Colors.white, // Set the color of the right border
                            width: 2.0, // Set the width of the right border
                          ),
                        ),
                      ),
                      child: Text(
                        'Roll $i',
                        style: TextStyle(color:Colors.white,fontSize: 16),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: cgpaControllers[i - 1],
                        decoration: InputDecoration(
                          labelText: 'CGPA',
                          border: InputBorder.none,
                          labelStyle: TextStyle(color: Colors.white), // Set label (hint) text color
                          contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                          hintStyle: TextStyle(color: Colors.white),  // Set hint text color
                        ),
                        style: TextStyle(color: Colors.white), // Set input text color
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 16),
            // Post Button
            Container(

              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed:_postDataToFirebase,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0), // Set the border radius to your desired value
                    ),
                  ),
                ),
                child: Text(
                  'Post',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      )
      ),
    )
    );
  }

  // Function to post data to Firebase
  void _postDataToFirebase() async {
    try {
      final user=FirebaseAuth.instance.currentUser;

      QuerySnapshot result1 = await FirebaseFirestore.instance.collection('classroom')
          .where('class_name', isEqualTo: widget.subject.name)
          .where('student', arrayContains: user!.uid).limit(1).get();
      QuerySnapshot result2 = await FirebaseFirestore.instance.collection('classroom')
          .where('class_name', isEqualTo: widget.subject.name)
          .where('teacher_id', isEqualTo: user!.uid).limit(1).get();

      List<DocumentSnapshot> ref_class = [
        ...result1.docs,
        ...result2.docs,
      ];
      //final ref_class = await FirebaseFirestore.instance.collection('classroom')
          //.where('class_name', isEqualTo: widget.subject.name).limit(1).get();

      List<double> allCgpa = cgpaControllers.map((controller) {
        String cgpaText = controller.text.trim();
        return double.tryParse(cgpaText) ?? 0.0; // Convert text to double, default to 0.0 if parsing fails
      }).toList();

      String classDocumentId = ref_class[0].id;

      //List<dynamic> existingCgpaList = ref_class.docs[0]['cgpa'] ?? [];

      Map<String, List<double>> termCG = {
        'termwisecgpa': allCgpa,
      };

      //List<double> updatedCgpaList = [...existingCgpaList.cast<double>(), ...allCgpa];

      await FirebaseFirestore.instance.collection('classroom').doc(classDocumentId).update({
        'cgpa': FieldValue.arrayUnion([termCG]),
      });

      //print(allCgpa);

      //User? user = FirebaseAuth.instance.currentUser;
      DocumentSnapshot userDoc = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user?.uid)
          .get();
      Map<String, dynamic> userData =
      userDoc.data() as Map<String, dynamic>;
      String posterName=userData['name'];

      MaterialPost post = MaterialPost(
        id: 1,
        title: "CGPA",
        description: "Your CGPA has been published!",
        postedAt: DateTime.now(),
        subjectId: classDocumentId!,
        postedBy: posterName!,
      );

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
      await FirebaseFirestore.instance.collection('classroom').doc(classDocumentId).update({
        'material' : FieldValue.arrayUnion(updated_post),
      });

      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SubjectView(subject: widget.subject,)),
      );


    }catch (e) {
      print('Error updating CGPA data: $e');
    }
  }
}