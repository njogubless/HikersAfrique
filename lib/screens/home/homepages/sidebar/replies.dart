import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hikersafrique/services/auth_notifier.dart';
import 'package:provider/provider.dart';

class RepliesPage extends StatelessWidget {
  const RepliesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthNotifier>(context).user!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Replies'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('feedback')
            .where('senderName', isEqualTo: user.clientName)
            .snapshots(),
        builder: (context, feedbackSnapshot) {
          if (feedbackSnapshot.hasError) {
            return const Center(child: Text('Error loading feedback'));
          }
          if (feedbackSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final feedbackDocs = feedbackSnapshot.data!.docs;

          return ListView.builder(
            itemCount: feedbackDocs.length,
            itemBuilder: (context, index) {
              final feedbackDoc = feedbackDocs[index];

              return ExpansionTile(
                title: Text(feedbackDoc['message']),
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('feedback')
                        .doc(feedbackDoc.id)
                        .collection('replies')
                        .orderBy('timestamp', descending: true)
                        .snapshots(),
                    builder: (context, replySnapshot) {
                      if (replySnapshot.hasError) {
                        return const Center(child: Text('Error loading replies'));
                      }
                      if (replySnapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final replyDocs = replySnapshot.data!.docs;

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: replyDocs.length,
                        itemBuilder: (context, replyIndex) {
                          final replyData =
                              replyDocs[replyIndex].data() as Map<String, dynamic>;

                          return ListTile(
                            title: Text(replyData['senderName']),
                            subtitle: Text(replyData['message']),
                          );
                        },
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
