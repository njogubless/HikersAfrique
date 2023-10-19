// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutterwave_standard/flutterwave.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  void _loadDotEnv() async {
    await dotenv.load(fileName: "assets/.env");
  }

  @override
  void initState() {
    super.initState();
    _loadDotEnv();
  }

  final snackBarSuccess = const SnackBar(
    content: Text('Payment Successful, Thanks for your patronage !'),
  );

  final snackBarFailure = const SnackBar(
    content: Text('Payment Unsuccessful, Please Try Again.'),
  );

  final String amount = "1000";
  final String txRef = "unique_transaction_ref_${Random().nextInt(1000000)}";

  void _makePayment() async {
    final style = FlutterwaveStyle(
        appBarText: "Pay with Flutterwave",
        buttonColor: Colors.orangeAccent,
        appBarIcon: Icon(Icons.payment_rounded, color: Colors.black),
        buttonTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        appBarColor: Colors.orange,
        dialogCancelTextStyle: const TextStyle(
          color: Colors.redAccent,
          fontSize: 18,
        ),
        dialogContinueTextStyle: const TextStyle(
          color: Colors.blue,
          fontSize: 18,
        ));

    final Customer customer = Customer(
        name: "FLW Customer",
        phoneNumber: "12345678910",
        email: "flwcustomer@qa.team");

    final Flutterwave flutterwave = Flutterwave(
        context: context,
        style: style,
        publicKey: dotenv.env['PUBLIC_KEY']!,
        currency: "KSH",
        txRef: txRef,
        amount: amount,
        customer: customer,
        paymentOptions: "ussd, card, barter, payattitude",
        customization: Customization(title: "Test Payment"),
        isTestMode: true);

    final ChargeResponse response = await flutterwave.charge();
    if (response != null) {
      print(response.toJson());
      if (response.success! && response.txRef == txRef) {
        ScaffoldMessenger.of(context).showSnackBar(snackBarSuccess);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(snackBarFailure);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(snackBarFailure);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Purchase ticket',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CheckOutSummary(),
          CheckOutCard(),
        ],
      ),
    );
  }

  Widget CheckOutSummary() {
    return Padding(
      padding: const EdgeInsets.all(22.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Total: KES $amount',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget CheckOutCard() {
    return InkWell(
      onTap: () {
        _makePayment();
      },
      child:  Card(
        margin: EdgeInsets.symmetric(horizontal: 10),
        color: Colors.orangeAccent,
        elevation: 15,
        child: Container(
          height: 100,
          child: Padding(
            padding: EdgeInsets.all(32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Pay with Flutterwave",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.payment_rounded,
                  size: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}