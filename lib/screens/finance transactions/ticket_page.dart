// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:hikersafrique/constant.dart';
import 'package:hikersafrique/models/client.dart';
import 'package:hikersafrique/models/event.dart';
import 'package:hikersafrique/screens/finance_manager/payment_model.dart';
import 'package:hikersafrique/screens/home/homepages/sidebar/feedbackselection.dart';

import '../home/homepages/cart.dart';


class TicketPage extends StatelessWidget {
  const TicketPage({
    Key? key,
    required this.event,
    required this.payment,
    required this.user,
    this.ispaymentApproved = false,
  }) : super(key: key);

  final event;
  final Payment payment;
  final Client user; // Adjust the type based on your user model
  final bool ispaymentApproved;

  @override
  Widget build(BuildContext context) {
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
              title: 'Proceed to Purchase Page',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Purchased(), // Navigate to the purchase page
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool isPrimary;

  const SecondaryButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.isPrimary = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: isPrimary
            ? MaterialStateProperty.all<Color>(Colors.black)
            : MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: isPrimary
                ? BorderSide.none
                : const BorderSide(color: Colors.black, width: 1),
          ),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isPrimary ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
