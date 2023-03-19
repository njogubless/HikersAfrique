import 'package:flutter/material.dart';
import 'package:hikersafrique/models/client.dart';
import 'package:hikersafrique/screens/authenticate/authenticate.dart';
import 'package:hikersafrique/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Return either Home or Authentication widget

    // Using the data from the Provider
    final userAuth = Provider.of<Client?>(context);

    // Return either Home() or Authenticate()
    if (userAuth == null) {
      return const Authenticate();
    } else {
      return const HomeScreen();
    }
  }
}
