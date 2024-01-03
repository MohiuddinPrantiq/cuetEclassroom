import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login_page.dart';

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
                        TextFormField(
                          controller: _nameController,
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
                          controller: _phoneNumberController,
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
                          controller: _hallController,
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
                          controller: _sidController,
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
                          controller: _emailController,
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
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
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
                              icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
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
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

  void _submitForm() async{
    if (_formKey.currentState?.validate() ?? true) {
      print('Name: ${_nameController.text}');
      print('Phone: ${_phoneNumberController.text}');
      print('Hall: ${_hallController.text}');
      print('Student ID: ${_sidController.text}');
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');

      String name = _nameController.text.trim();
      String phone = _phoneNumberController.text.trim();
      String hall = _hallController.text.trim();
      String sid = _sidController.text.trim();
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

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