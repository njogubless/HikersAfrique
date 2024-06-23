import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hikersafrique/screens/home/homepages/sidebar/replies.dart';
import 'package:hikersafrique/services/auth_notifier.dart';
import 'package:provider/provider.dart';


class FeedbackReplyScreen extends StatefulWidget {
  final DocumentSnapshot feedback;
  const FeedbackReplyScreen({Key? key, required this.feedback}) : super(key: key);

  @override
  State<FeedbackReplyScreen> createState() => _FeedbackReplyScreenState();
}

class _FeedbackReplyScreenState extends State<FeedbackReplyScreen> {
  final TextEditingController _replyController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthNotifier>(context).user!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reply to Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(widget.feedback['message']),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('feedback')
                    .doc(widget.feedback.id)
                    .collection('replies')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Error loading replies'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final List<DocumentSnapshot> replies = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: replies.length,
                    itemBuilder: (context, index) {
                      final Map<String, dynamic> replyData =
                          replies[index].data() as Map<String, dynamic>;

                      final String senderName = replyData['senderName'] ?? 'Unknown';
                      final String message = replyData['message'] ?? '';

                      return ListTile(
                        title: Text(senderName),
                        subtitle: Text(message),
                      );
                    },
                  );
                },
              ),
            ),
            TextFormField(
              controller: _replyController,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                hintText: 'Enter your reply here',
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              maxLines: 5,
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        final repliesCollection = FirebaseFirestore.instance
                            .collection('feedback')
                            .doc(widget.feedback.id)
                            .collection('replies');

                        await repliesCollection.add({
                          'timestamp': FieldValue.serverTimestamp(),
                          'message': _replyController.text,
                          'senderName': user.clientName,
                          'senderRole': user.role,
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Reply sent successfully')),
                        );
                        _replyController.clear();
                        Navigator.pop(context); // Close reply screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RepliesPage(),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Error sending reply')),
                        );
                      }
                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: const Text('Send Reply'),
                  ),
          ],
        ),
      ),
    );
  }
}
