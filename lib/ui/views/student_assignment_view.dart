import 'package:flutter/material.dart';

import '../widgets/Assignment_individual.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignment App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AssignmentWidget(),
    );
  }
}
