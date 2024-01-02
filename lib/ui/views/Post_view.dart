// post_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PostView extends StatelessWidget {
  final String postTitle;
  final String postContent;

  // Example list of comments
  final List<String> comments = [
    'Comment 1',
    'Comment 2',
    'Comment 3',
    // Add more comments as needed
  ];

  PostView({
    Key? key,
    required this.postTitle,
    required this.postContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
                  'Post Details',
                  style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
        ),
        backgroundColor: Colors.transparent, // Set the background color to transparent
        elevation: 0, // Remove the shadow
       //brightness: Brightness.dark, // Set brightness to dark for white text
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // User avatar and post information
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  // Add user avatar here
                  backgroundColor: Colors.grey, // Placeholder color
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
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Posted at [timestamp]', // Replace with actual timestamp
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Default content with larger box
            Container(
              margin: const EdgeInsets.only(bottom: 25),
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text(
                    postTitle,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    postContent,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // Add Comment button
            ElevatedButton.icon(
              onPressed: () {
                // Handle adding comment
              },
              icon: Icon(Icons.comment),
              label: Text('Add Comment'),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                onPrimary: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            // Comments section
            Text(
              'Comments',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            // Display comments in box-wise format
            Column(
              children: comments.map((comment) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        // Add user avatar for each comment
                        backgroundColor: Colors.grey, // Placeholder color
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
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            comment,
                            style: TextStyle(
                              color: Colors.white,
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
    );
  }
}
