import 'package:flutter/material.dart';
import 'package:hikersafrique/models/client.dart';
import 'package:hikersafrique/screens/finance_manager/payment_model.dart';
import 'package:hikersafrique/services/auth_notifier.dart';
import 'package:hikersafrique/services/database.dart';
import 'package:provider/provider.dart';

import '../../finance transactions/ticket_page.dart';

class Purchased extends StatelessWidget {
  const Purchased({Key? key}) : super(key: key);

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

              if (payments.isEmpty) {
                return const Center(child: Text('No events purchased.'));
              }

              return ListView.builder(
                itemCount: payments.length,
                itemBuilder: (context, index) {
                  final payment = payments[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                      trailing: _buildDownloadButton(context, payment, user),
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

  // Function to build event status with color-coded text
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

  // Function to build the download button, only visible for approved events
  Widget _buildDownloadButton(BuildContext context, Payment payment, Client? user) {
    if (payment.status.toLowerCase() == 'approved' && user != null) {
      return ElevatedButton(
        onPressed: () {
          // Navigate to the TicketPage when the button is pressed
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TicketPage(
                event: payment.event,
                payment: payment,
                user: user,
              ),
            ),
          );
        },
        child: const Text('Download Ticket'),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
