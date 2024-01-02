import 'package:flutter/material.dart';

class Attendance extends StatefulWidget {
  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  List<bool> buttonStates = List.generate(200, (index) => false);

  @override
  Widget build(BuildContext context) {
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
                submitButtonStates();
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

  void submitButtonStates() {
    // Add logic to submit buttonStates
    print("Submitting buttonStates: $buttonStates");
  }
}