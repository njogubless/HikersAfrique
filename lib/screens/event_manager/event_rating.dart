import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRatingsPage extends StatelessWidget {
  const UserRatingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Ratings'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('rates').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final ratings = snapshot.data!.docs;

          return ListView.builder(
            itemCount: ratings.length,
            itemBuilder: (context, index) {
              final ratingData = ratings[index].data() as Map<String, dynamic>;
              return Card(
                child: ListTile(
                  title: Text('Client: ${ratingData['clientName']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Rating: ${ratingData['rating']}'),
                      Text('Comment: ${ratingData['comment']}'),
                      Text('Event ID: ${ratingData['eventId']}'),
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
}
