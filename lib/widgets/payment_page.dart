import 'package:flutter/material.dart';
import 'package:hikersafrique/models/event.dart';
import 'package:hikersafrique/services/auth_notifier.dart';
import 'package:hikersafrique/services/database.dart';
import 'package:hikersafrique/widgets/ticket_page.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key, required this.event});

  final Event event;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool _paying = false;
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
            SecondaryButton(
              isPrimary: true,
              onPressed: () {
                setState(() {
                  _paying = true;
                });
                Database.saveBookedEvent(
                        user!.clientEmail, widget.event.eventID)
                    .then((_) {
                  setState(() {
                    _paying = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Colors.greenAccent,
                    content: Text(
                        'Event booked!\nWe will contact you for further instructions'),
                  ));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TicketPage(
                          event: widget.event,
                        ),
                      ));
                });
              },
              title: _paying ? 'Purchasing ticket...' : 'Pay & Book ticket now',
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
    required this.title,
    this.isPrimary = false,
    this.onPressed,
    super.key,
  });

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
