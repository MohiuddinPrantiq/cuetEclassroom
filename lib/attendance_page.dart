import 'package:flutter/material.dart';

class Attendance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: Text(
            'Attendacne',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
            ),),
          centerTitle: true,
          elevation: 10,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(143, 148, 251, 1),
                      Color.fromRGBO(143, 148, 251, .6),
                    ]
                )
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Expanded( // Wrap DynamicButtonGrid with Expanded
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: DynamicButtonGrid(),
              ),
            ),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(143, 148, 251, 1),
                      Color.fromRGBO(143, 148, 251, .6),
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    "Proceed",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

            ),

            SizedBox(height: 10),
          ],
        ),

      ),
    );
  }
}

class DynamicButtonGrid extends StatefulWidget {
  @override
  _DynamicButtonGridState createState() => _DynamicButtonGridState();
}

class _DynamicButtonGridState extends State<DynamicButtonGrid> {
  List<bool> buttonStates = [];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: buttonStates.length,
      itemBuilder: (context, index) {
        int buttonValue = index + 1;
        Color buttonColor = buttonStates[index] ? Colors.red : Colors.green;

        return InkWell(
          onTap: () {
            setState(() {
              buttonStates[index] = !buttonStates[index];
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(20.0), // Adjust border radius as needed
            ),
            child: Center(
              child: Text(
                buttonValue.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // Initialize button states with green initially
    for (int i = 0; i < 200; i++) {
      buttonStates.add(false);
    }
  }
}
