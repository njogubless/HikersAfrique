// Colours
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hikersafrique/models/client.dart';
import 'package:hikersafrique/models/event.dart';
import 'package:hikersafrique/screens/finance_manager/payment_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

const darkGrey = Color.fromARGB(255, 96, 99, 103);
const lightGrey = Color.fromARGB(255, 169, 170, 175);
const lightBlue = Color.fromARGB(255, 35, 156, 243);
const white = Color.fromARGB(255, 255, 255, 255);
const darkPurp = Color.fromARGB(255, 60, 7, 93);
const textColor = Color(0xFF535353);
const textLightColor = Color(0xFFACACAC);

// Padding
const defaultPadding = 20.0;

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: const Center(
        child: SpinKitDoubleBounce(
          color: lightBlue,
          size: 100.0,
        ),
      ),
    );
  }
}

class Misc {
  static Future<void> getReceipt(Event event, Payment payment,Client client, BuildContext context) async {
    final pdf = pw.Document();

    final eventImage = await networkImage(event.eventImageUrl);

    final fontStyle = pw.TextStyle(
        color: PdfColors.blueAccent,
        fontSize: 30,
        fontBold: pw.Font.timesBold());

         // Initialize payment object with the provided totalCost
    //Payment payment = Payment(totalCost: totalCost);

    // Debug print payment.totalCost
    //print('Payment total cost: ${event.totalCost}');
        

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Image(eventImage),
              pw.SizedBox(height: 50),
              pw.Text("Name: ${client.clientName}", style: fontStyle),
              pw.Text("Event: ${event.eventName}", style: fontStyle),
              pw.Text("Amount paid: Ksh.${payment.totalCost}", style: fontStyle),
              pw.Text("Total Amount Paid: Ksh.$event totalAmount",style:fontStyle),
              pw.Text("Date: ${event.eventDate}", style: fontStyle),
              pw.Text("Time:${event.eventTime}",style: fontStyle),           ],
          ); // Center
        }));

    // Generate a unique identifier for the receipt, e.g., timestamp
    final uniqueIdentifier = DateTime.now().millisecondsSinceEpoch;

    final file = File(
        "/storage/emulated/0/Download/${event.eventName.toLowerCase().replaceAll(' ', '_')}_receipt_$uniqueIdentifier.pdf");
    await file.writeAsBytes(await pdf.save());

    // Optionally, you can also display a message indicating that the receipt was saved
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.greenAccent,
      content: Text('Receipt downloaded successfully!'),
    ));
  }
}
