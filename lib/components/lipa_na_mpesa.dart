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
                  "A1d5SfyYCLMFnRvULne7ii5DeqGuYKQ8NnBty7TKkUlEGSgdx6u96lxX3ujo/+lzG6pD2ShvISQe578pZ4hTH68KAUabfngZUituRzKEqh1JP3J4d/mX1Zl+D08Fd/GArwzpHSrRW30LxTXvfrQ+H56gm5mcyv1aBhWBggh8P6YTDbrlfg58L9ht0+c8+7mFRubNQWVWRKhMW5HijMI69G+dX2QJeLNJk8KEyZAuvJFUtuebsMtsvO1Xdf9347PzDQCxR/ry70S5M8LeVx6XaPvtl+4waI69f8EwWD90s3zd7GxyBBbG4LE5IhuRpC7MsTUIMymrZBaga/4pMu7gDA==");
//This passkey has been generated from Test Credentials from Safaricom Portal

      return transactionInitialisation;
    } catch (e) {
      print("CAUGHT EXCEPTION: $e");
    }
  }
}
