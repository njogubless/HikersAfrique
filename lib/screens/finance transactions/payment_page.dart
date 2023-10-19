// ignore_for_file: unused_local_variable, prefer_final_fields, unused_field, unused_import

import 'package:flutter/material.dart';
import 'package:hikersafrique/screens/finance%20transactions/bankPayments.dart';
import 'package:hikersafrique/models/event.dart';
import 'package:hikersafrique/services/auth_notifier.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  final Event event;

  const PaymentPage({Key? key, required this.event}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

    @override
  void initState() {
    super.initState();
    // ignore: prefer_const_constructors
  }

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
            const Text(
              'Are you sure you want to book?',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 50),
            Image.network(
              widget.event.eventImageUrl,
              fit: BoxFit.fitWidth,
            ),
            const SizedBox(height: 50),
         ElevatedButton(
              onPressed: () {
                // Handle the ticket purchase logic here
                Navigator.push( context,
                  MaterialPageRoute(builder: (context) => const CheckOutPage()),);
              },
              child: const Text("Purchase Ticket"),
            ),
            const SizedBox(height: 20),
            SecondaryButton(
              title: 'Cancel',
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    Key? key,
    required this.title,
    this.isPrimary = false,
    this.onPressed,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String title;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: isPrimary ? Colors.blue : const Color(0xFFFFFFFF),
      minWidth: double.infinity,
      height: 55,
      elevation: 0,
      highlightElevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      disabledElevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isPrimary ? const Color(0xFFFFFFFF) : Colors.blue,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
