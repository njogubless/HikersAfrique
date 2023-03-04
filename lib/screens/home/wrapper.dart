import 'package:flutter/material.dart';
import 'package:hikersafrique/screens/home/home_screen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    //return either home or authenticate widget
    return const HomeScreen();
  }
}
