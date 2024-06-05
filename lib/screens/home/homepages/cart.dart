// ignore_for_file: unnecessary_cast, unused_local_variable, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hikersafrique/screens/finance_manager/payment_model.dart';
import 'package:hikersafrique/services/auth_notifier.dart';
import 'package:hikersafrique/services/database.dart';
import 'package:hikersafrique/services/paymentprovider.dart';
import 'package:provider/provider.dart';

import '../../../models/client.dart';

class Purchased extends StatelessWidget {
  const Purchased({Key? key}) : super(key: key);

  Future<void> getMypaymentstatus() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String userEmail = Provider.of<AuthNotifier>(context, listen: false).email;
    QuerySnapshot paymentSnapshot =
        await firestore.collection('payments').get();

    List<QueryDocumentSnapshot> userPayments =
        paymentSnapshot.docs.where((doc) {
      return doc['email'] == userEmail;
    }).toList();

    bool isApproved = false;
    for (var payment in userPayments) {
      if (payment['status'] == 'approved') {
        isApproved = true;
        break;
      }
    }
  } /*
  Check the payments collection, and return the lists of documents in the paymentCollection

  For each document, look through the snapshots and compare the data()['email'] with the user email,
  if they are thesame, return that document snapshot.
  At the end of it, you should have a list of documentsnaphot.

  From those list of the document snapshot, you can access the snaphot data and get the payment status.

  When the payment status is approved, pass boolean true to the ticket page, to enable the download button;

 */

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthNotifier>(context).user as Client?;
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
                trailing: _buildDownloadButton(context, payment, user),
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

  Widget _buildDownloadButton(
      BuildContext context, Payment payment, Client? user) {
    if (payment.status == 'approved' && user != null) {
      return ElevatedButton(
        onPressed: () {
          // Navigate to the TicketPage when the button is pressed
          var widget;
          // Navigator.push(
          //   context,
          // MaterialPageRoute(
          //   builder: (context) => TicketPage(
          //       event: payment.event, payment: payment, user: widget.user),
          // ),
          // );
        },
        child: const Text('Download Ticket'),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
