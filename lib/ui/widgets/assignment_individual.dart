import 'package:flutter/material.dart';
import '../../data/model/subject_assignment.dart';
import '../theme/app_color.dart';
import 'package:intl/intl.dart';

class AssignmentWidget extends StatefulWidget {
  final SubjectAssignment assignment;

  AssignmentWidget({required this.assignment});

  @override
  _AssignmentWidgetState createState() => _AssignmentWidgetState();
}

class _AssignmentWidgetState extends State<AssignmentWidget> {
  bool isTurnedIn = false;

  // Example list of comments
  final List<String> comments = [
    'Comment 1',
    'Comment 2',
    'Comment 3',
    // Add more comments as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Assignment Details',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          // Display status (Missing or Turned In) in the app bar
          Container(
            margin: EdgeInsets.only(right: 16),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isTurnedIn ? AppColor.green : AppColor.red,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              isTurnedIn ? 'Turned In' : 'Missing',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Assignment Title
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColor.dark, width: 1.3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.assignment.title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColor.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.assignment.description,
                    style: TextStyle(fontSize: 16, color: AppColor.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Comment button
            Container(
              width: double.infinity, // Make the button as wide as the parent
              child: ElevatedButton(
                onPressed: () {
                  // Handle adding comment
                },
                child: Text('Attach PDF', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  primary: AppColor.purpleGradientStart,
                  onPrimary: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 16),
            // Attach PDF button
            Container(
              width: double.infinity, // Make the button as wide as the parent
              child: ElevatedButton(
                onPressed: () {
                  // Implement logic for attaching PDF
                },
                child: Text('Mark as Done', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  primary: AppColor.purpleGradientStart,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 32), // Adjust width
                ),
              ),
            ),
            SizedBox(height: 16),
            // Add Comment button
            Container(
              width: double.infinity, // Make the button as wide as the parent
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isTurnedIn = true;
                  });
                },
                child: Text('Add Comment', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  primary: AppColor.purpleGradientStart,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 32), // Adjust width
                ),
              ),
            ),
            SizedBox(height: 16),
            // Comment section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColor.dark, width: 1.3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Comments',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColor.white),
                  ),
                  const SizedBox(height: 8),
                  // Display comments in box-wise format
                  Column(
                    children: comments.map((comment) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColor.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              // Add user avatar for each comment
                              backgroundColor: AppColor.grey, // Placeholder color
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Username', // Replace with actual username
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.white,
                                  ),
                                ),
                                Text(
                                  comment,
                                  style: TextStyle(
                                    color: AppColor.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}