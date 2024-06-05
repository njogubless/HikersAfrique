import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackListScreen extends StatelessWidget {
  const FeedbackListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('feedback').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List<DocumentSnapshot> feedbacks = snapshot.data!.docs;

          return ListView.builder(
            itemCount: feedbacks.length,
            itemBuilder: (context, index) {
              final Map<String, dynamic> feedbackData = feedbacks[index].data() as Map<String, dynamic>;

              // Extracting timestamp and role
              final Timestamp timestamp = feedbackData['timestamp'] as Timestamp;
              final String role = feedbackData['role'] ?? 'N/A';

              return ListTile(
                title: Text(feedbackData['name'] ?? ''),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(feedbackData['message'] ?? ''),
                    Text(
                      'Role: $role',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      'Timestamp: ${_formatTimestamp(timestamp)}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _formatTimestamp(Timestamp timestamp) {
    final DateTime dateTime = timestamp.toDate();
    final String formattedDateTime = '${dateTime.day}/${dateTime.month}/${dateTime.year} '
        '${_formatTime(dateTime.hour)}:${_formatTime(dateTime.minute)}:${_formatTime(dateTime.second)}';
    return formattedDateTime;
  }

  String _formatTime(int time) {
    return time < 10 ? '0$time' : '$time';
  }
}
