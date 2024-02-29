import 'package:flutter/material.dart';
import 'package:hikersafrique/models/event.dart';

class PaymentConfirmationPage extends StatelessWidget {
  final Event event;
  final double totalCost;
  final int ticketCount;

  const PaymentConfirmationPage({
    Key? key,
    required this.event,
    required this.totalCost,
    required this.ticketCount,
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
            Text('Number of Tickets Paid: $ticketCount'),
            Text('Amount Paid: Ksh. $totalCost'),
            // You may want to add more details such as payment method here
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
