import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login_page.dart';


enum UserType { student, teacher }

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _hallController = TextEditingController();
  TextEditingController _sidController = TextEditingController();

  TextEditingController _designationController = TextEditingController(); // Add this controller for teacher
  TextEditingController _departmentController = TextEditingController(); // Add this controller for teacher

  UserType _selectedUserType = UserType.student;
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 350,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          fit: BoxFit.fill
                      )
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 30,
                        width: 80,
                        height: 200,
                        child: FadeInUp(duration: Duration(seconds: 1), child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/light-1.png')
                              )
                          ),
                        )),
                      ),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 150,
                        child: FadeInUp(duration: Duration(milliseconds: 1200), child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/light-2.png')
                              )
                          ),
                        )),
                      ),
                      Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 150,
                        child: FadeInUp(duration: Duration(milliseconds: 1300), child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/clock.png')
                              )
                          ),
                        )),
                      ),
                      Positioned(
                        child: FadeInUp(duration: Duration(milliseconds: 1600), child: Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Center(
                            child: Text("Signup", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
                          ),
                        )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: ListTile(
                            title: Center(child:Text('Create Account as:',style: TextStyle(color: Colors.white,fontSize: 22),),),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Radio(
                                  value: UserType.student,
                                  groupValue: _selectedUserType,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedUserType = UserType.student;
                                    });
                                  },
                                ),
                                Text('Student',style: TextStyle(color: Colors.white,fontSize: 20),),
                                SizedBox(width: 30.0),
                                Radio(
                                  value: UserType.teacher,
                                  groupValue: _selectedUserType,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedUserType = UserType.teacher;
                                    });
                                  },
                                ),
                                Text('Teacher',style: TextStyle(color: Colors.white,fontSize: 20),),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        // Display the appropriate form based on the user's selection
                        _selectedUserType == UserType.student
                            ? StudentForm(
                          formKey: _formKey,
                          nameController: _nameController,
                          phoneNumberController: _phoneNumberController,
                          emailController: _emailController,
                          passwordController: _passwordController,
                          hallController: _hallController,
                          sidController: _sidController,
                          isPasswordVisible: _isPasswordVisible,
                        )
                            : TeacherForm(
                          formKey: _formKey,
                          nameController: _nameController,
                          phoneNumberController: _phoneNumberController,
                          emailController: _emailController,
                          passwordController: _passwordController,
                          designationController: _designationController,
                          departmentController: _departmentController,
                          isPasswordVisible: _isPasswordVisible,
                        ),
                        // ... (existing code)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}

// Define the StudentForm widget
class StudentForm extends StatefulWidget {
  // ... (existing code)
  GlobalKey<FormState> formKey;
  TextEditingController nameController;
  TextEditingController phoneNumberController;
  TextEditingController emailController;
  TextEditingController passwordController;
  TextEditingController hallController;
  TextEditingController sidController;
  bool isPasswordVisible;

  // Constructor for initializing the StudentForm fields
  StudentForm({
    required this.formKey,
    required this.nameController,
    required this.phoneNumberController,
    required this.emailController,
    required this.passwordController,
    required this.hallController,
    required this.sidController,
    required this.isPasswordVisible,
  });

  @override
  State<StudentForm> createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormField(
          controller: widget.nameController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0), // Set border radius
              borderSide: BorderSide(
                color: Color.fromRGBO(143, 148, 251, 1), // Set border color
                width: 2.0, // Set border width
              ),
            ),
            labelText: 'Name',
            labelStyle: TextStyle(color: Colors.white),
          ),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Please enter your Name';
            }
            return null;
          },
        ),
        SizedBox(height: 16.0),
        TextFormField(
          controller: widget.phoneNumberController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0), // Set border radius
              borderSide: BorderSide(
                color: Color.fromRGBO(143, 148, 251, 1), // Set border color
                width: 2.0, // Set border width
              ),
            ),
            labelText: 'Phone Number',
            labelStyle: TextStyle(color: Colors.white),
          ),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Please enter your Phone Number';
            }
            return null;
          },
        ),
        SizedBox(height: 16.0),
        TextFormField(
          controller: widget.hallController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0), // Set border radius
              borderSide: BorderSide(
                color: Color.fromRGBO(143, 148, 251, 1), // Set border color
                width: 2.0, // Set border width
              ),
            ),
            labelText: 'Hall Name',
            labelStyle: TextStyle(color: Colors.white),
          ),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Please enter your Hall Name';
            }
            return null;
          },
        ),
        SizedBox(height: 16.0),
        TextFormField(
          controller: widget.sidController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0), // Set border radius
              borderSide: BorderSide(
                color: Color.fromRGBO(143, 148, 251, 1), // Set border color
                width: 2.0, // Set border width
              ),
            ),
            labelText: 'Student ID',
            labelStyle: TextStyle(color: Colors.white),
          ),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Please enter your Student ID';
            }
            return null;
          },
        ),
        SizedBox(height: 16.0),
        TextFormField(
          controller: widget.emailController,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0), // Set border radius
              borderSide: BorderSide(
                color: Color.fromRGBO(143, 148, 251, 1), // Set border color
                width: 2.0, // Set border width
              ),
            ),
            labelText: 'Email Address',
            labelStyle: TextStyle(color: Colors.white),
          ),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Please enter your email address';
            }
            return null;
          },
        ),
        SizedBox(height: 16.0),
        TextFormField(
          controller: widget.passwordController,
          obscureText: !widget.isPasswordVisible,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0), // Set border radius
              borderSide: BorderSide(
                color: Color.fromRGBO(143, 148, 251, 1), // Set border color
                width: 2.0, // Set border width
              ),
            ),
            labelText: 'Password',
            labelStyle: TextStyle(color: Colors.white),
            suffixIcon: IconButton(
              icon: Icon(widget.isPasswordVisible ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  widget.isPasswordVisible = !widget.isPasswordVisible;
                });
              },
            ),
          ),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Please enter your password';
            }
            return null;
          },
        ),
        SizedBox(height: 24.0),
        Container(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size.fromHeight(50),
              backgroundColor: Color.fromRGBO(143, 148, 251, 1),// Adjust the height as needed
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0), // Set border radius
              ),
            ),
            onPressed: _submitForm,
            child: Text(
              'Signup',
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),
            ),
          ),
        ),
        SizedBox(height: 50,),
        GestureDetector(
          onTap: () {
            // Implement your "Forgot Password?" action
            print('Login is tapped');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          child: FadeInUp(duration: Duration(milliseconds: 2000), child: Text("Have Account! Login", style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),)),
        ),
        SizedBox(height: 30,),
      ],
    );
  }

  void _submitForm() async{
    if (widget.formKey.currentState?.validate() ?? true) {
      print('Name: ${widget.nameController.text}');
      print('Phone: ${widget.phoneNumberController.text}');
      print('Hall: ${widget.hallController.text}');
      print('Student ID: ${widget.sidController.text}');
      print('Email: ${widget.emailController.text}');
      print('Password: ${widget.passwordController.text}');

      String name = widget.nameController.text.trim();
      String phone = widget.phoneNumberController.text.trim();
      String hall = widget.hallController.text.trim();
      String sid = widget.sidController.text.trim();
      String email = widget.emailController.text.trim();
      String password = widget.passwordController.text.trim();

      if(name=="" || phone=="" || hall=="" || sid=="" || email=="" || password==""){
        print("please fill all the details");
      } else{
        try{
          UserCredential userCredential = await FirebaseAuth.instance.
          createUserWithEmailAndPassword(email: email, password: password);

          Map<String, dynamic> newUser={
            "name" : name,
            "phone" : phone,
            "hall" : hall,
            "sid" : sid,
            "email" : email,
            "type" : "student",
          };

          await FirebaseFirestore.instance.collection('users').
          doc(userCredential.user!.uid).set(newUser);

          print("user created and info is stored");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()), // Replace LoginPage with your actual login page
          );
        } on FirebaseAuthException catch (ex){
          print(ex.code.toString()); // good to create a snackbar
        }

      }
    }
  }
}

// Define the TeacherForm widget
class TeacherForm extends StatefulWidget {
  // ... (existing code)
  GlobalKey<FormState> formKey;
  TextEditingController nameController;
  TextEditingController phoneNumberController;
  TextEditingController emailController;
  TextEditingController passwordController;
  TextEditingController designationController;
  TextEditingController departmentController;
  bool isPasswordVisible;

  // Constructor for initializing the TeacherForm fields
  TeacherForm({
    required this.formKey,
    required this.nameController,
    required this.phoneNumberController,
    required this.emailController,
    required this.passwordController,
    required this.designationController,
    required this.departmentController,
    required this.isPasswordVisible,
  });

  @override
  State<TeacherForm> createState() => _TeacherFormState();
}

class _TeacherFormState extends State<TeacherForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormField(
          controller: widget.nameController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0), // Set border radius
              borderSide: BorderSide(
                color: Color.fromRGBO(143, 148, 251, 1), // Set border color
                width: 2.0, // Set border width
              ),
            ),
            labelText: 'Name',
            labelStyle: TextStyle(color: Colors.white),
          ),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Please enter your Name';
            }
            return null;
          },
        ),
        SizedBox(height: 16.0),
        TextFormField(
          controller: widget.phoneNumberController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0), // Set border radius
              borderSide: BorderSide(
                color: Color.fromRGBO(143, 148, 251, 1), // Set border color
                width: 2.0, // Set border width
              ),
            ),
            labelText: 'Phone Number',
            labelStyle: TextStyle(color: Colors.white),
          ),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Please enter your Phone Number';
            }
            return null;
          },
        ),
        SizedBox(height: 16.0),
        TextFormField(
          controller: widget.departmentController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0), // Set border radius
              borderSide: BorderSide(
                color: Color.fromRGBO(143, 148, 251, 1), // Set border color
                width: 2.0, // Set border width
              ),
            ),
            labelText: 'Department Name',
            labelStyle: TextStyle(color: Colors.white),
          ),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Please enter your Department Name';
            }
            return null;
          },
        ),
        SizedBox(height: 16.0),
        TextFormField(
          controller: widget.designationController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0), // Set border radius
              borderSide: BorderSide(
                color: Color.fromRGBO(143, 148, 251, 1), // Set border color
                width: 2.0, // Set border width
              ),
            ),
            labelText: 'Designation',
            labelStyle: TextStyle(color: Colors.white),
          ),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Please enter your Designation';
            }
            return null;
          },
        ),
        SizedBox(height: 16.0),
        TextFormField(
          controller: widget.emailController,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0), // Set border radius
              borderSide: BorderSide(
                color: Color.fromRGBO(143, 148, 251, 1), // Set border color
                width: 2.0, // Set border width
              ),
            ),
            labelText: 'Email Address',
            labelStyle: TextStyle(color: Colors.white),
          ),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Please enter your email address';
            }
            return null;
          },
        ),
        SizedBox(height: 16.0),
        TextFormField(
          controller: widget.passwordController,
          obscureText: !widget.isPasswordVisible,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0), // Set border radius
              borderSide: BorderSide(
                color: Color.fromRGBO(143, 148, 251, 1), // Set border color
                width: 2.0, // Set border width
              ),
            ),
            labelText: 'Password',
            labelStyle: TextStyle(color: Colors.white),
            suffixIcon: IconButton(
              icon: Icon(widget.isPasswordVisible ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  widget.isPasswordVisible = !widget.isPasswordVisible;
                });
              },
            ),
          ),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Please enter your password';
            }
            return null;
          },
        ),
        SizedBox(height: 24.0),
        Container(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size.fromHeight(50),
              backgroundColor: Color.fromRGBO(143, 148, 251, 1),// Adjust the height as needed
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0), // Set border radius
              ),
            ),
            onPressed: _submitForm,
            child: Text(
              'Signup',
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),
            ),
          ),
        ),
        SizedBox(height: 50,),
        GestureDetector(
          onTap: () {
            // Implement your "Forgot Password?" action
            print('Login is tapped');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          child: FadeInUp(duration: Duration(milliseconds: 2000), child: Text("Have Account! Login", style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),)),
        ),
        SizedBox(height: 30,),
      ],
    );
  }

  void _submitForm() async{
    if (widget.formKey.currentState?.validate() ?? true) {
      print('Name: ${widget.nameController.text}');
      print('Phone: ${widget.phoneNumberController.text}');
      print('Department: ${widget.departmentController.text}');
      print('Designation: ${widget.designationController.text}');
      print('Email: ${widget.emailController.text}');
      print('Password: ${widget.passwordController.text}');

      String name = widget.nameController.text.trim();
      String phone = widget.phoneNumberController.text.trim();
      String department = widget.departmentController.text.trim();
      String designation = widget.designationController.text.trim();
      String email = widget.emailController.text.trim();
      String password = widget.passwordController.text.trim();

      if(name=="" || phone=="" || department=="" || designation=="" || email=="" || password==""){
        print("please fill all the details");
      } else{
        try{
          UserCredential userCredential = await FirebaseAuth.instance.
          createUserWithEmailAndPassword(email: email, password: password);

          Map<String, dynamic> newUser={
            "name" : name,
            "phone" : phone,
            "department" : department,
            "designation" : designation,
            "email" : email,
            "type" : "teacher",
          };

          await FirebaseFirestore.instance.collection('users').
          doc(userCredential.user!.uid).set(newUser);

          print("user created and info is stored");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()), // Replace LoginPage with your actual login page
          );
        } on FirebaseAuthException catch (ex){
          print(ex.code.toString()); // good to create a snackbar
        }
      }
    }
  }
}