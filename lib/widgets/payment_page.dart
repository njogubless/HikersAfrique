// ignore_for_file: non_constant_identifier_names, unused_field, unused_local_variable, equal_elements_in_set

import 'package:flutter/material.dart';
import 'package:hikersafrique/models/event.dart';
import 'package:hikersafrique/services/auth_notifier.dart';
import 'package:provider/provider.dart';
import 'package:hikersafrique/components/lipa_na_mpesa.dart';

class PaymentPage extends StatefulWidget {
  final Event event;

  const PaymentPage({super.key, required this.event});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final bool _paying = false;

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
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF481E4D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: () {
                LipaNaMpesa();
              },
              child: const Text(
                "Lipa na Mpesa",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  LipaNaMpesa();
                },
                child: const Text("Purchase Ticket")),
            // SecondaryButton(
            //   isPrimary: true,
            //   onPressed: () {
            //     LipaNaMpesa();
            //     // Database.saveBookedEvent(
            //     //         user!.clientEmail, widget.event.eventID)
            //     //     .then((_) {
            //     //   setState(() {
            //     //     _paying = false;
            //     //   });
            //     //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            //     //     backgroundColor: Colors.greenAccent,
            //     //     content: Text(
            //     //         'Event booked!\nWe will contact you for further instructions'),
            //     //   ));
            //     //   // Navigator.push(
            //     //   //     context,
            //     //   //     MaterialPageRoute(
            //     //   //       builder: (context) => TicketPage(
            //     //   //         event: widget.event,
            //     //   //       ),
            //     //   //     ));
            //     // });
            //   },
            //   title: 'Pay & Book ticket now'
            //   // _paying ? 'Purchasing ticket...' : 'Pay & Book ticket now',
            // ),
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
