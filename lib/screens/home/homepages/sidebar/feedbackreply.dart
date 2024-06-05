import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
            TextFormField(
              controller: _replyController,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                hintText: 'Enter your reply here',
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
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
                          //'senderId': uid.clientuid,
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Reply sent successfully')),
                        );
                        Navigator.pop(context);
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
