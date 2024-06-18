import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hikersafrique/screens/home/homepages/sidebar/feedbackreply.dart';
import 'package:provider/provider.dart';

import '../../../../services/auth_notifier.dart';


class FeedbackListScreen extends StatelessWidget {
  const FeedbackListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthNotifier>(context).user!;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback List'),
        backgroundColor: Colors.teal,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('feedback')
            .where('recipientRole', isEqualTo: user.role) // Filter by user role
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading feedback'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final List<DocumentSnapshot> feedbacks = snapshot.data!.docs;

          return ListView.builder(
            itemCount: feedbacks.length,
            itemBuilder: (context, index) {
              final Map<String, dynamic> feedbackData =
                  feedbacks[index].data() as Map<String, dynamic>;

              final Timestamp timestamp = feedbackData['timestamp'] as Timestamp;
              final String role = feedbackData['role'] ?? 'N/A';
              final String name = feedbackData['name'] ?? '';
              final String message = feedbackData['message'] ?? '';

              return Card(
                margin: const EdgeInsets.all(8.0),
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FeedbackReplyScreen(feedback: feedbacks[index]),
                      ),
                    );
                  },
                  title: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8.0),
                      Text(
                        message,
                        style: const TextStyle(fontSize: 16.0, color: Colors.black87),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                    ],
                  ),
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
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} '
        '${_formatTime(dateTime.hour)}:${_formatTime(dateTime.minute)}:${_formatTime(dateTime.second)}';
  }

  String _formatTime(int time) {
    return time < 10 ? '0$time' : '$time';
  }
}

