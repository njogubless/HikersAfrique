import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hikersafrique/models/event.dart';
// ignore: unused_import
import 'package:hikersafrique/services/auth_notifier.dart';

class PaymentConfirmationPage extends StatelessWidget {
  final Event event;
  final User user;
  const PaymentConfirmationPage({
    Key? key,
    required this.event, required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Confirmation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
                'Number of Events Paid: 1'), // You can replace '1' with the actual count
            const Text(
                'Amount Paid: \$XXX'), // Replace '\$XXX' with the actual amount
            const Text(
                'Mpesa Code: ABC123'), // Replace 'ABC123' with the actual Mpesa code
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle the logic for additional payment or navigate to another screen
                // For now, let's just show a success message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Payment Done Successfully!'),
                  ),
                );
              },
              child: const Text('Pay'),
            ),
          ],
        ),
      ),
    );
  }
}
