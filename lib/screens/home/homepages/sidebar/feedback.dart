import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hikersafrique/services/auth_notifier.dart';
import 'package:provider/provider.dart';
//import 'package:flutter_firebase_feedback_form/firebase_options.dart';


class FeedbackDialog extends StatefulWidget {
  final String recipient;
  const FeedbackDialog({Key? key, required this.recipient}) : super(key: key);

  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthNotifier>(context).user!;
    
    return AlertDialog(
      title: const Text('Send Feedback'),
      content: TextField(
        controller: _messageController,
        maxLines: 5,
        decoration: const InputDecoration(
          hintText: 'Enter your feedback here',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            final feedbackCollection = FirebaseFirestore.instance.collection('feedback');
            await feedbackCollection.add({
              'timestamp': FieldValue.serverTimestamp(),
              'message': _messageController.text,
              'senderName': user.clientName,
              'senderRole': user.role,
              'recipientRole': widget.recipient,
            });
            Navigator.pop(context);
          },
          child: const Text('Send'),
        ),
      ],
    );
  }
}


