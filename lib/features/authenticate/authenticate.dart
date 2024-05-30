import 'package:flutter/material.dart';
import 'package:hikersafrique/features/authenticate/register.dart';
import 'package:hikersafrique/features/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  // Handling the toggling of the Sign In and Register forms
  bool showSignIn = true;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      // Passing the function down so that it can be accessed to toggle View
      return SignIn(toggleView: toggleView);
    } else {
      // Passing the function down so that it can be accessed to toggle View
      return RegisterClient(toggleView: toggleView);
    }
  }
}
