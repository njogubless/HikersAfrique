// // ignore_for_file: file_names, depend_on_referenced_packages
// // ignore_for_file: avoid_print

// import 'dart:async';
// import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

// class LipaNaMpesa {
//   var consumerKey =
//       MpesaFlutterPlugin.setConsumerKey("gNoAXe4uCzYG2Rg0iwS80LxfkOXVdLkA");
//   var consumerSecret =
//       MpesaFlutterPlugin.setConsumerSecret("zDZBHDyuNYE51dHM ");

// //create the lipaNaMpesa method here.Please note, the method can have any name, I chose lipaNaMpesa
//   Future<void> lipaNaMpesa( double totalAmount) async {
//     dynamic transactionInitialisation;
//     try {
//       transactionInitialisation =
//           await MpesaFlutterPlugin.initializeMpesaSTKPush(
//               businessShortCode: "174379",
//               transactionType: TransactionType.CustomerPayBillOnline,
//               amount: totalAmount,
//               partyA: "254746179799",
//               partyB: "600000",
// //Lipa na Mpesa Online ShortCode
//               callBackURL: Uri(
//                   scheme: "https",
//                   host: "mpesa-requestbin.herokuapp.com",
//                   path: "/1hhy6391"),
// //This url has been generated from http://mpesa-requestbin.herokuapp.com/?ref=hackernoon.com for test purposes
//               accountReference: "CompanyXLTD",
//               phoneNumber: "254746179799",
//               baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
//               transactionDesc: "Test",
//               passKey:
//                   "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919");
// //This passkey has been generated from Test Credentials from Safaricom Portal

//       return transactionInitialisation;
//     } catch (e) {
//       print("CAUGHT EXCEPTION: $e");
//     }
//   }
// }