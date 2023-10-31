// // ignore_for_file: avoid_print, library_private_types_in_public_api

// import 'package:flutter/material.dart';
// import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

// class LipaNaMpesa extends StatefulWidget {
//   const LipaNaMpesa(
//       {required this.consumerKey, required this.consumerSecret, Key? key})
//       : super(key: key);

//   final String consumerKey;
//   final String consumerSecret;

//   @override
//   _LipaNaMpesaState createState() => _LipaNaMpesaState();
// }

// class _LipaNaMpesaState extends State<LipaNaMpesa> {
//   @override
//   void initState() {
//     super.initState();
//     MpesaFlutterPlugin.setConsumerKey(widget.consumerKey);
//     MpesaFlutterPlugin.setConsumerSecret(widget.consumerSecret);
//   }

//   Future<void> _lipaNaMpesa() async {
//     try {
//       final transactionInitialization =
//           await MpesaFlutterPlugin.initializeMpesaSTKPush(
//         businessShortCode: "174379",
//         transactionType: TransactionType.CustomerPayBillOnline,
//         amount: 1.0,
//         partyA: "254792964487",
//         partyB: "174379",
//         callBackURL: Uri(
//             scheme: "https",
//             host: "mpesa-requestbin.herokuapp.com",
//             path: "/1hhy6391"),
//         accountReference: " Hikers Afrique",
//         phoneNumber: "0746179799",
//         baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
//         transactionDesc: "purchase",
//         passKey:
//             "A1d5SfyYCLMFnRvULne7ii5DeqGuYKQ8NnBty7TKkUlEGSgdx6u96lxX3ujo/+lzG6pD2ShvISQe578pZ4hTH68KAUabfngZUituRzKEqh1JP3J4d/mX1Zl+D08Fd/GArwzpHSrRW30LxTXvfrQ+H56gm5mcyv1aBhWBggh8P6YTDbrlfg58L9ht0+c8+7mFRubNQWVWRKhMW5HijMI69G+dX2QJeLNJk8KEyZAuvJFUtuebsMtsvO1Xdf9347PzDQCxR/ry70S5M8LeVx6XaPvtl+4waI69f8EwWD90s3zd7GxyBBbG4LE5IhuRpC7MsTUIMymrZBaga/4pMu7gDA==",
//       );

//       if (transactionInitialization != null) {
//         print('Mpesa transaction initialized successfully!');
//       } else {
//         print('Mpesa transaction initialization failed.');
//       }
//     } catch (e) {
//       print("CAUGHT EXCEPTION: $e");
//       rethrow;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<void>(
//       future: _lipaNaMpesa(),
//       builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           return const Text('Mpesa transaction initialized successfully!');
//         }
//       },
//     );
//   }
// }