import 'package:flutter/material.dart';
import 'package:flutterwave/flutterwave.dart';

class LipaNaMpesa extends StatefulWidget {
  const LipaNaMpesa({Key? key}) : super(key: key);

  @override
  State<LipaNaMpesa> createState() => _LipaNaMpesaState();
}

class _LipaNaMpesaState extends State<LipaNaMpesa> {
  final String currency = FlutterwaveCurrency.KES;
  final formKey = GlobalKey<FormState>();
  TextEditingController? fullname;
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController amount = TextEditingController();

  void _makeFlutterwavePayment(BuildContext context, String fullname,
      String phone, String email, String amount) async {
    try {
      Flutterwave flutterwave = Flutterwave.forUIPayment(
          //the first 10 fields below are required/mandatory
          context: this.context,
          fullName: fullname,
          phoneNumber: phone,
          email: email,
          amount: amount,
          //Use your Public and Encription Keys from your Flutterwave account on the dashboard
          encryptionKey: "FLWSECK_TEST4134cbfbcc25",
          publicKey: "FLWPUBK_TEST-d6191ca2de5a84b203f5d28659079b61-X",
          currency: currency,
          txRef: DateTime.now().toIso8601String(),
          //Setting DebugMode below to true since will be using test mode.
          //You can set it to false when using production environment.
          isDebugMode: true,
          //configure the the type of payments that your business will accept
          acceptCardPayment: false,
          acceptUSSDPayment: false,
          acceptAccountPayment: false,
          acceptFrancophoneMobileMoney: false,
          acceptGhanaPayment: false,
          acceptMpesaPayment: true,
          acceptRwandaMoneyPayment: false,
          acceptUgandaPayment: false,
          acceptZambiaPayment: false);
      final response = await flutterwave.initializeForUiPayments();
      // ignore: unnecessary_null_comparison
      if (response == null) {
        print("Transaction Failed");
      } else {
        if (response.status == "Transaction successful") {
          print(response.data);
          print(response.message);
        } else {
          print(response.message);
        }
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter + Flutterwave'),
        centerTitle: true,
      ),
      body: 
      Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.all(10.0)),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  controller: fullname,
                  decoration: const InputDecoration(labelText: "Full Name"),
                  validator: (value) =>
                      value!.isNotEmpty ? null : "Please fill in Your Name",
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  controller: phone,
                  decoration: const InputDecoration(labelText: "Phone Number"),
                  validator: (value) => value!.isNotEmpty
                      ? null
                      : "Please fill in Your Phone number",
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  controller: email,
                  decoration: const InputDecoration(labelText: "Email"),
                  validator: (value) =>
                      value!.isNotEmpty ? null : "Please fill in Your Email",
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  controller: amount,
                  decoration: const InputDecoration(labelText: "Amount"),
                  validator: (value) => value!.isNotEmpty
                      ? null
                      : "Please fill in the Amount you are Paying",
                ),
              ),
              ElevatedButton(
                child: const Text('Pay with Flutterwave'),
                onPressed: () {
                  final name = fullname.toString();
                  final userPhone = phone.toString();
                  final userEmail = email.toString();
                  final amountPaid = amount.toString();

                  if (formKey.currentState!.validate()) {
                    _makeFlutterwavePayment(
                        context, name, userPhone, userEmail, amountPaid);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
