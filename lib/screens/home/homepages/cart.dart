// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:hikersafrique/models/client.dart';
import 'package:hikersafrique/screens/admin/logistics.dart';
import 'package:hikersafrique/screens/finance_manager/payment_model.dart';
import 'package:hikersafrique/screens/home/homepages/sidebar/feedbackselection.dart';
import 'package:hikersafrique/services/auth_notifier.dart';
import 'package:hikersafrique/services/database.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../../finance transactions/ticket_page.dart';

class Purchased extends StatelessWidget {
  const Purchased({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchased Events'),
      ),
      body: Consumer<AuthNotifier>(
        builder: (context, authNotifier, _) {
          final user = authNotifier.user;
          return FutureBuilder<List<Payment>>(
            future: Database.getrecordPayments(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final List<Payment> payments = snapshot.data ?? [];
              final clientPayments = payments
                  .where((payment) => payment.email == user?.clientEmail)
                  .toList();

              if (clientPayments.isEmpty) {
                return const Center(child: Text('No events purchased.'));
              }

              return ListView.builder(
                itemCount: clientPayments.length + 1, // +1 for the footer item
                itemBuilder: (context, index) {
                  if (index == clientPayments.length) {
                    // Footer item (Finish button)
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SecondaryButton(
                        title: 'Finish',
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Give Feedback?'),
                                content: const Text(
                                    'Do you want to give feedback for your trip?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      //Navigator.of(context).pop();
                                      //Navigator.of(context).pop();
                                      //Navigator.of(context).pop();
                                      //Navigator.of(context).pop();
                                    },
                                    child: const Text('No'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const FeedbackRecipientSelection(),
                                        ),
                                      );
                                    },
                                    child: const Text('Yes'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    );
                  }

                  final payment = clientPayments[index];
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      title: Text(
                        payment.event,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Client: ${payment.clientName}'),
                          Text('Email: ${payment.email}'),
                          Text('Total Cost: \$${payment.totalCost}'),
                          _buildEventStatus(payment.status),
                        ],
                      ),
                      trailing:
                          _buildDownloadButton(context, payment, user),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildEventStatus(String status) {
    Color statusColor;
    String displayStatus;

    switch (status.toLowerCase()) {
      case 'pending':
        statusColor = Colors.orange;
        displayStatus = 'Pending';
        break;
      case 'approved':
        statusColor = Colors.green;
        displayStatus = 'Approved';
        break;
      case 'rejected':
        statusColor = Colors.red;
        displayStatus = 'Rejected';
        break;
      default:
        statusColor = Colors.grey;
        displayStatus = 'Unknown';
    }

    return Text(
      displayStatus,
      style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildDownloadButton(
      BuildContext context, Payment payment, Client? user) {
    if (payment.status.toLowerCase() == 'approved' && user != null) {
      return ElevatedButton(
        onPressed: () {
          Misc.getReceipt(payment, user, context).then((_) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.greenAccent,
              content: Text('Find your receipt in your Downloads!'),
            ));
          });
        },
        child: const Text('Download Ticket'),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

// Ensure you have this SecondaryButton widget implemented
class SecondaryButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const SecondaryButton({
    required this.title,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey, // Customize the button color
      ),
      child: Text(title),
    );
  }
}
