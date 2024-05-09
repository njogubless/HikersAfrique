// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:hikersafrique/screens/finance%20transactions/ticket_page.dart';
//import 'package:hikersafrique/models/payment.dart';
import 'package:hikersafrique/screens/finance_manager/payment_model.dart';
///import 'package:hikersafrique/screens/ticket_page.dart';
import 'package:hikersafrique/services/auth_notifier.dart';
import 'package:hikersafrique/services/database.dart';
import 'package:hikersafrique/services/paymentprovider.dart';
import 'package:provider/provider.dart';

class Purchased extends StatelessWidget {
  const Purchased({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthNotifier>(context).user;
    final paymentProvider = Provider.of<PaymentProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchased Events'),
      ),
      body: FutureBuilder<List<Payment>>(
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
              return ListTile(
                title: Text(payment.event),
                subtitle: _buildEventStatus(payment.status),
                trailing: _buildDownloadButton(context, payment, event),
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

    switch (status) {
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

  Widget _buildDownloadButton(BuildContext context, Payment payment, event ) {
    if (payment.status == 'approved') {
      return ElevatedButton(
        onPressed: () {
          // Navigate to the TicketPage when the button is pressed
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TicketPage(event: event , payment: payment,),
            ),
          );
        },
        child: const Text('Download Ticket'),
      );
    } else {
      return const   SizedBox.shrink();
    }
  }
}
