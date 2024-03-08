import 'package:flutter/material.dart';
import 'package:hikersafrique/screens/finance transactions/payment_page.dart';
import 'package:hikersafrique/screens/finance_manager/payment_model.dart';
import 'package:provider/provider.dart';
import 'package:hikersafrique/constant.dart';
import 'package:hikersafrique/models/event.dart';
import 'package:hikersafrique/services/auth_notifier.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({Key? key, required this.event, required this.payment}) : super(key: key);

  final Event event;
  final Payment payment;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthNotifier>(context).user;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Successfully booked!',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Please check back soon',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 20),
            SecondaryButton(
              isPrimary: true,
              title: 'Download ticket',
              onPressed: () {
                Misc.getReceipt(event, payment, user!, context).then((_) =>
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.greenAccent,
                      content: Text('Find your receipt in your Downloads!'),
                    )));
              },
            ),
            const SizedBox(height: 20),
            SecondaryButton(
              title: 'Finish',
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
