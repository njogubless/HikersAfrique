import 'package:flutter/material.dart';
import 'package:hikersafrique/screens/home/homepages/sidebar/feedback.dart';

class FeedbackRecipientSelection extends StatelessWidget {
  const FeedbackRecipientSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final recipients = ['guides', 'drivers', 'financeManager', 'eventManager', 'partners', 'logistics'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Recipient'),
      ),
      body: ListView.builder(
        itemCount: recipients.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(recipients[index]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FeedbackDialog(recipient: recipients[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
