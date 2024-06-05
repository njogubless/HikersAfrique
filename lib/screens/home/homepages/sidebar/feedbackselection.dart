import 'package:flutter/material.dart';
import 'package:hikersafrique/screens/home/homepages/sidebar/feedback.dart';

class FeedbackRecipientSelection extends StatelessWidget {
  const FeedbackRecipientSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recipients = ['guide', 'drivers', 'financeManager', 'eventManager', 'partner','logistics',];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Recipient'),
      ),
      body: ListView.builder(
        itemCount: recipients.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(recipients[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FeedbackDialog(recipient: recipients[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
