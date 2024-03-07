// ignore_for_file: unused_import, unused_local_variable

import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:hikersafrique/models/event.dart';
import 'package:hikersafrique/screens/finance%20transactions/payment_confirmation_page.dart';
import 'package:hikersafrique/screens/finance%20transactions/ticket_page.dart';
import 'package:hikersafrique/screens/finance_manager/payment_model.dart';
import 'package:hikersafrique/services/auth_notifier.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import FirebaseFirestore

// Define the Payment class here...

// Define the recordPayments function outside of the _PaymentPageState class
Future<void> recordPayments(List<Payment> payments) async {
  try {
    final CollectionReference paymentCollection = FirebaseFirestore.instance.collection('payments');

    // Loop through the payments and set each one to Firestore
    for (var payment in payments) {
      final DocumentReference docRef = paymentCollection.doc(); // Get a new document reference
      await docRef.set({
        'clientName': payment.clientName,
        'amountPaid': payment.amountPaid,
        'totalCost': payment.totalCost,
        'email': payment.email,
        'event': payment.event,
        'mpesaCode': payment.mpesaCode,
      });
    }
    print('Payments added successfully to Firestore');
  } catch (e) {
    print('Error adding payments to Firestore: $e');
    throw e; // Rethrow the error for the caller to handle
  }
}

class PaymentPage extends StatefulWidget {
  final Event event;

  const PaymentPage({Key? key, required this.event}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController _ticketCountController = TextEditingController();
  final TextEditingController _costController = TextEditingController();
  final TextEditingController _mpesaCodeController = TextEditingController();
  final TextEditingController clientNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController eventController = TextEditingController();
  final TextEditingController amountPaidController = TextEditingController();

  @override
  void dispose() {
    _ticketCountController.dispose();
    _costController.dispose();
    _mpesaCodeController.dispose(); // Dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
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
              const Text(
                'Enter the number of tickets you want:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _ticketCountController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _updateTotalCost(); // Call the function to update total cost
                },
                decoration: const InputDecoration(
                  labelText: 'Number of Tickets',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _costController,
                readOnly: true,
                style: const TextStyle(color: Colors.teal),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _mpesaCodeController,
                decoration: const InputDecoration(
                  labelText: 'M-Pesa Code',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _handlePurchase();
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
      ),
    );
  }

  void _updateTotalCost() {
    double ticketCount = double.tryParse(_ticketCountController.text) ?? 0;
    double eventCostPerTicket = widget.event.eventCost.toDouble();
    double totalCost = ticketCount * eventCostPerTicket;
    setState(() {
      _costController.text = "Total Cost: Ksh. $totalCost";
    });
  }

  void _handlePurchase() {
    double ticketCount = double.tryParse(_ticketCountController.text) ?? 0;
    double eventCostPerTicket = widget.event.eventCost.toDouble();
    double totalCost = ticketCount * eventCostPerTicket;

    // Get the M-Pesa code from the text field
    String mpesaCode = _mpesaCodeController.text;
    String clientName = clientNameController.text;
    String email = emailController.text;
    String event = eventController.text;
    double amountPaid = double.tryParse(amountPaidController.text) ?? 0.0;

    // Perform payment logic here...
    Payment payment = Payment(
      clientName: clientName,
      amountPaid: amountPaid,
      email: email,
      event: event,
      mpesaCode: mpesaCode,
      totalCost: totalCost,
    );
    // Assuming payment is successful
    recordPayments([payment]).then((_) {
      // Payment recorded successfully, navigate to ticket page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TicketPage(event: widget.event),
        ),
      );
    });
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
