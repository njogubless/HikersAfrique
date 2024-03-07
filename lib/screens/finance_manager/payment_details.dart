import 'package:flutter/material.dart';
import 'package:hikersafrique/screens/finance_manager/payment_model.dart';
import 'package:hikersafrique/services/database.dart';

class FinanceManagerHome extends StatelessWidget {
  const FinanceManagerHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:const PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: FinanceManagerAppBar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              const SizedBox(height: 20.0),
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                  MaterialPageRoute(builder: (context) => const PaymentDetailsScreen()));
                },
                child:const Card(
                  elevation: 4,
                  margin: EdgeInsets.all(8),
                  child: Padding(
                    padding:EdgeInsets.all(16)),
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FinanceManagerAppBar extends StatelessWidget {
  const FinanceManagerAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6.0,
                    )
                  ],
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: const Icon(Icons.sort_rounded, size: 28.0),
              ),
            ),
            const Row(
              children: [
                Icon(
                  Icons.supervised_user_circle_rounded,
                  color: Color(0xFFF65959),
                ),
                Text(
                  'Finance Manager',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                )
              ],
            ),
            DropdownButton<int>(
              icon: const Icon(Icons.more_vert),
              underline: const SizedBox.shrink(),
              items: const [
                DropdownMenuItem(
                  value: 1,
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontFamily: 'AvenirNext',
                    ),
                  ),
                ),
              ],
              onChanged: (selection) {
                // Handle dropdown item selection
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentDetailsScreen extends StatelessWidget {
  const PaymentDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Payment>>(
      future: Database
          .getrecordPayments(), // Assume this method retrieves payment details
      initialData: const [],
      builder: (context, snapshot) {
        final List<Payment> payments = snapshot.data!;
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Client Name')),
              DataColumn(label: Text('Amount Paid')),
              //DataColumn(label: Text('Email')),
              DataColumn(label: Text('Event')),
              DataColumn(label: Text('M-Pesa Code')),
              DataColumn(label: Text('Action')),
            ],
            rows: payments.map((payment) {
              return DataRow(cells: [
                DataCell(Text(payment.clientName)),
                DataCell(Text(payment.amountPaid.toString())),
                DataCell(Text(payment.email)),
                DataCell(Text(payment.event)),
                DataCell(Text(payment
                    .mpesaCode)), // Assuming you have mpesa code in payment model
                DataCell(Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.check),
                      onPressed: () {
                        // Code to approve payment
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        // Code to reject payment
                      },
                    ),
                  ],
                )),
              ]);
            }).toList(),
          ),
        );
      },
    );
  }
}
