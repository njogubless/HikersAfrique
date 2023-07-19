// ignore_for_file: override_on_non_overriding_member, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

class LipanaMpesa extends StatefulWidget {
  const LipanaMpesa(
      {required this.consumerKey, required this.consumerSecret, Key? key})
      : super(key: key);

  final String consumerKey;
  final String consumerSecret;

  @override
  _LipanaMpesaState createState() => _LipanaMpesaState();
}

class _LipanaMpesaState extends State<LipanaMpesa> {
  @override
  void initstate() {
    super.initState();
    MpesaFlutterPlugin.setConsumerKey(widget.consumerKey);
    MpesaFlutterPlugin.setConsumerSecret(widget.consumerSecret);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: lipaNaMpesa(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const Text('Mpesa transaction initialized successfully!');
        }
      },
    );
  }

  Future<void> lipaNaMpesa() async {
    dynamic transactionInitialization;
    try {
      dynamic widget;
      MpesaFlutterPlugin.setConsumerKey(widget.consumerKey);
      MpesaFlutterPlugin.setConsumerSecret(widget.consumerSecret);

      transactionInitialization =
          await MpesaFlutterPlugin.initializeMpesaSTKPush(
        businessShortCode: "174379",
        transactionType: TransactionType.CustomerPayBillOnline,
        amount: 1.0,
        partyA: "0746179799",
        partyB: "174379",
        callBackURL:
            Uri.parse("https://mpesa-requestbin.herokuapp.com/1hhy6391"),
        accountReference: "Hikers Afrique",
        phoneNumber: "0746179799",
        baseUri: Uri.parse("https://sandbox.safaricom.co.ke"),
        transactionDesc: "purchase",
        passKey:
            "XKRmoyvapv+XPvfuJafq6thvHG1JuJBnn9TTBKugrIWpDXGlfyHNGo3vPmH1iM2LL57SA7hsjqI0dK7Wl3tAVhNduaGlKfyHK7tNGF46CwRC4LcwfqngYcYi+Rrx/fVZYNOHNWTWEmw4CjwoeeEB40z+zUEfElHfFyWeUBC1GDI3cwoH9+pLkJHhowlicBr3WTlvtx8wdWRUZ1efbYjsDMiGu76fwlIQHzXNy+nqPJPuMFfw6/rEHPwGwwXQ+rFlbkrRHUKA0teaJUaqE6nCNfELIEPPYFXwo+dAVM7LFhT1hfRr8emcm57hGjQMA3Y0F4JmPNl5AFrM5ThMJi5nDA==",
      );

      return transactionInitialization;
    } catch (e) {
      print("CAUGHT EXCEPTION: $e");
      rethrow;
    }
  }
}
