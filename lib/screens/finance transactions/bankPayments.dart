// ignore_for_file: unused_import, non_constant_identifier_names, unused_local_variable

import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MaterialApp(
    home: CheckOutPage(),
  ));
}

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final TextEditingController _ticketController = TextEditingController();
  int _numberOfTickets = 0;

// define the ticket price here
  int ticketPrice = 1000;

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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _ticketController,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: 'Enter number of tickets'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                // Parse the input as an integer and update the number of tickets
                _numberOfTickets = int.tryParse(_ticketController.text) ?? 0;
              });
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  Widget CheckOutSummary() {
// calculate the total amount based on the number of tickets and ticket price
    int totalAmount = _numberOfTickets * ticketPrice;

    return Padding(
      padding: const EdgeInsets.all(22.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Total: KES $totalAmount) * _numberOfTickets}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
