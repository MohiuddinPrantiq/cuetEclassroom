import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class Announcement_page extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<Announcement_page> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  String ?_selectedType;
  DateTime ?_selectedDate;
  TextEditingController _descriptionController = TextEditingController();
  List<PlatformFile> _selectedFiles = [];
  final format = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
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
                    items: ['Assignment', 'Quiz', 'Notice']
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
                  DateTimeField(
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

  void _submitForm() {
    if (_formKey.currentState?.validate()?? true) {
      // Perform the form submission
      // You can access the form data using _titleController.text, _selectedType, _selectedDate, _descriptionController.text, and _selectedFiles
      print('Title: ${_titleController.text}');
      print('Type: $_selectedType');
      print('Deadline: $_selectedDate');
      print('Description: ${_descriptionController.text}');
      print('Selected Files: $_selectedFiles');
    }
  }
}

