import 'package:flutter/cupertino.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

class Mpesa extends StatefulWidget {
  const Mpesa({super.key});

  @override
  State<Mpesa> createState() => _MpesaState();
}

class _MpesaState extends State<Mpesa> {
  void main(){
    MpesaFlutterPlugin.setConsumerKey("bQXCwTspKlnSoAxkQ9SyQIcGj6lO8XIW");
    MpesaFlutterPlugin.setConsumerSecret("KY0Uc9BHVInAAeAA");
    runApp(new MyApp());

  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
