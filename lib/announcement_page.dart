import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuet/data/model/notification.dart';
import 'package:cuet/data/model/subject_assignment.dart';
import 'package:cuet/data/model/material_post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

import 'data/model/subject.dart';

class Announcement_page extends StatefulWidget {

  final Subject subject;
  // Constructor that takes a Subject object
  Announcement_page({Key? key, required this.subject}) : super(key: key);





  @override

  _MyFormState createState() => _MyFormState();

}

String? sub_id;

class _MyFormState extends State<Announcement_page> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  String ?_selectedType;
  DateTime ?_selectedDate;
  TextEditingController _descriptionController = TextEditingController();
  List<PlatformFile> _selectedFiles = [];
  final format = DateFormat("yyyy-MM-dd");


  @override
  Future<void> get_sub() async {
    try {

      //logic for finding class_id using name
      final ref_class = await FirebaseFirestore.instance.collection('classroom')
          .where('class_name', isEqualTo: widget.subject.name).limit(1).get();
      sub_id = ref_class.docs.first.id;

    } catch (error) {
      print('Error fetching enrolled classes: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    get_sub();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          'Create Post',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.white
          ),),
        centerTitle: true,
        elevation: 10,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(36, 110, 233, 1)
          ),
        ),
      ),
      body: SingleChildScrollView(
        child:Center(
          child:Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: _titleController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0), // Set border radius
                        borderSide: BorderSide(
                          color: Color.fromRGBO(80, 00, 80, 1), // Set border color
                          width: 2.0, // Set border width
                        ),
                      ),
                      labelText: 'Title',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: _selectedType,
                    items: ['Assignment', 'Quiz', 'Materials']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedType = value;
                      });
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0), // Set border radius
                        borderSide: BorderSide(
                          color: Color.fromRGBO(80, 00, 80, 1), // Set border color
                          width: 2.0, // Set border width
                        ),
                      ),
                      labelText: 'Type',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20),
                  _selectedType == "Materials"? SizedBox(height: 0.1) : DateTimeField(
                    format: DateFormat("yyyy-MM-dd HH:mm"),
                    onShowPicker: (context, currentValue) async {
                      final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (date != null) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(
                              currentValue ?? DateTime.now()),
                        );
                        return DateTimeField.combine(date, time);
                      } else {
                        return currentValue;
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        _selectedDate = value;
                      });
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.calendar_month),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0), // Set border radius
                        borderSide: BorderSide(
                          color: Color.fromRGBO(80, 00, 80, 1), // Set border color
                          width: 2.0, // Set border width
                        ),
                      ),
                      labelText: 'Select Deadline',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _descriptionController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0), // Set border radius
                          borderSide: BorderSide(
                            color: Color.fromRGBO(80, 00, 80, 1), // Set border color
                            width: 2.0, // Set border width
                          ),
                        ),
                        labelText: 'Description',
                        labelStyle: TextStyle(color: Colors.white),
                        alignLabelWithHint: true
                    ),
                    maxLines: 6,
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size.fromHeight(50),
                          backgroundColor: Color.fromRGBO(36, 110, 233, 1)// Adjust the height as needed
                      ),
                      onPressed: _selectFiles,
                      child: Text(
                        'Select Files',
                        style: TextStyle(fontSize: 20,color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Selected Files: ${_selectedFiles.isNotEmpty ? _getFileNames() : 'None'}',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size.fromHeight(50),
                          backgroundColor: Color.fromRGBO(36, 110, 233, 1)// Adjust the height as needed
                      ),
                      onPressed: _submitForm,
                      child: Text(
                        'Post',
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getFileNames() {
    return _selectedFiles.map((file) => file.name).join(', ');
  }

  void _selectFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        _selectedFiles = result.files;
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate()?? true) {
      // Perform the form submission
      // You can access the form data using _titleController.text, _selectedType, _selectedDate, _descriptionController.text, and _selectedFiles
      print('Title: ${_titleController.text}');
      print('Type: $_selectedType');
      print('Deadline: $_selectedDate');
      print('Description: ${_descriptionController.text}');
      print('Selected Files: $_selectedFiles');
      if(_selectedType == 'Materials') {
        MaterialPost post = MaterialPost(
          id: 1,
          title: _titleController.text,
          description: _descriptionController.text,
          postedAt: DateTime.now(),
          subjectId: sub_id!
        );
        print(sub_id);

        //adding in material collection
        CollectionReference materialdb = FirebaseFirestore.instance.collection('Material');
        DocumentReference doc_ref = await materialdb.add({
          "title" : post.title,
          "description" : post.description,
          "posted" :  post.postedAt,
          "subject" : post.subjectId,
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
      }
      else {
          SubjectAssignment post = SubjectAssignment(
              id: 1,
              title: _titleController.text,
              description: _descriptionController.text,
              postedAt: DateTime.now(),
              dueAt: DateTime.now(),
              subjectId: sub_id!,
              type: SubjectAssignmentType.missing
          );
          print(sub_id);

          //adding in material collection
          CollectionReference assigndb = FirebaseFirestore.instance.collection('assignment');
          DocumentReference doc_ref = await assigndb.add({
            "title" : post.title,
            "description" : post.description,
            "posted" :  post.postedAt,
            "due" : post.dueAt,
            "subject" : post.subjectId,
          });
          List updated_as = [];
          updated_as.add(doc_ref.id);

          //updating in database
          try {
            var refdb = await FirebaseFirestore.instance.collection('classroom');
            await refdb.doc(sub_id).update({
              'assignment' : FieldValue.arrayUnion(updated_as),
            });
            print('added successfully');
          } on FirebaseAuthException catch (ex){
            print(ex.code.toString());
          }
      }
       NotificationItem notification = NotificationItem(
           title : _titleController.text,
           message: _descriptionController.text,
           time: _selectedDate.toString(),
       );
     notification_list.add(notification);
     notification_list.reversed;
      Navigator.pop(context);
    }
  }
}

