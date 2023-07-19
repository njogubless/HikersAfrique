import 'dart:async';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

class LipaNaMpesa {
  var consumerKey = MpesaFlutterPlugin.setConsumerKey("gNoAXe4uCzYG2Rg0iwS80LxfkOXVdLkA");
  var consumerSecret = MpesaFlutterPlugin.setConsumerSecret("zDZBHDyuNYE51dHM ");

//create the lipaNaMpesa method here.Please note, the method can have any name, I chose lipaNaMpesa
  Future<void> lipaNaMpesa() async {
    dynamic transactionInitialisation;
    try {
      transactionInitialisation =
          await MpesaFlutterPlugin.initializeMpesaSTKPush(
              businessShortCode: "174379",
              transactionType: TransactionType.CustomerPayBillOnline,
              amount: 1.0,
              partyA: "254792964487",
              partyB: "174379",
//Lipa na Mpesa Online ShortCode
              callBackURL: Uri(
                  scheme: "https",
                  host: "mpesa-requestbin.herokuapp.com",
                  path: "/1hhy6391"),
//This url has been generated from http://mpesa-requestbin.herokuapp.com/?ref=hackernoon.com for test purposes
              accountReference: " Hikers Afrique",
              phoneNumber: "0746179799",
              baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
              transactionDesc: "purchase",
              passKey:
                  "Get Your Pass Key from Test Credentials its random eg..'c893059b1788uihh'...");
//This passkey has been generated from Test Credentials from Safaricom Portal

      return transactionInitialisation;
    } catch (e) {
      print("CAUGHT EXCEPTION: $e");
    }
  }
}
