// ignore_for_file: unused_import, unused_local_variable

import 'package:flutter/material.dart';
import 'package:hikersafrique/models/event.dart';
import 'package:hikersafrique/screens/finance%20transactions/Lipa_Na_Mpesa.dart';
import 'package:hikersafrique/services/auth_notifier.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  final Event event;

  const PaymentPage({Key? key, required this.event}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController _ticketCountController = TextEditingController();
  @override
  void initState() {
    super.initState();
    MpesaFlutterPlugin.setConsumerKey('gvgIlzbPLCURrX7JnBdEL1QxGl7G367T');
    MpesaFlutterPlugin.setConsumerSecret('GJlA9WKlCosHAx5q');
  }
  Future<void> lipaNaMpesa() async {
    try {
      final transactionInitialization =
      await MpesaFlutterPlugin.initializeMpesaSTKPush(
        businessShortCode: "174379",
        transactionType: TransactionType.CustomerPayBillOnline,
        amount: 10.0,
        partyA: "254746179799",
        partyB: "174379",
        callBackURL: Uri(
            scheme: "https",
            host: "lms.smm.co.ke",
            path: "/api"),
        accountReference: " Hikers Afrique",
        phoneNumber: "254746179799",
        baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
        transactionDesc: "purchase",
        passKey:"bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919");

      if (transactionInitialization != null) {
        print('Mpesa transaction initialized successfully!');
      } else {
        print('Mpesa transaction initialization failed.');
      }
    } catch (e) {
      print("CAUGHT EXCEPTION: $e");
      rethrow;
    }
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
            const SizedBox(height: 20),
            Image.network(widget.event.eventImageUrl, fit: BoxFit.fitWidth),
          SingleChildScrollView(
  child: Column(
    children: [
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
        decoration: const InputDecoration(
          labelText: 'Number of Tickets',
          border: OutlineInputBorder(),
        ),
      ),
      // Other widgets can be added here
    ],
  ),
),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // lipaNaMpesa();
                // double ticketCount =
                //     double.tryParse(_ticketCountController.text) ?? 0;
                // double eventCostPerTicket = (widget.event.ticketPrice)
                //     .toDouble(); // Replace this with the actual property for ticket cost

                // double totalAmount = (ticketCount) * (eventCostPerTicket);
                // print('totalAmount');

                BuildContext currentContext = context;
                lipaNaMpesa().then((_) {
                  ScaffoldMessenger.of(currentContext).showSnackBar(
                    const SnackBar(content: Text('Payment Successful!')),
                  );
                }).catchError((error) {
                  ScaffoldMessenger.of(currentContext).showSnackBar(
                    SnackBar(content: Text('Payment Failed: $error')),
                  );
                });
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