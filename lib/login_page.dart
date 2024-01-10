import 'package:cuet/data/home_data.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'signup_page.dart';
import 'ui/views/home_view.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
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
                  height: 400,
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
                            child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
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
                              'Login',
                              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(height: 70,),
                        GestureDetector(
                          onTap: () {
                            // Implement your "Forgot Password?" action
                            print('signin is tapped');
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => SignupPage()),
                            );
                          },
                          child: FadeInUp(duration: Duration(milliseconds: 2000), child: Text("Create Account!", style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),)),
                        )
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

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? true) {
      // Form is valid, handle login logic here using _emailController.text and _passwordController.text
      // For simplicity, just print the values for now
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');

      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      if(email == "" || password=="") {
        print("please fill all the fields");
      } else {
        try{
          UserCredential userCredential = await FirebaseAuth.instance.
          signInWithEmailAndPassword(email: email, password: password);

          if(userCredential.user != null){
            //enrolled_class();
            print(subjects.length);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeView()), // Replace LoginPage with your actual login page
            );
          }
        } on FirebaseAuthException catch (ex){
          print(ex.code.toString()); // good to create a snackbar
        }
      }

    }
  }


}