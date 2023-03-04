// Colours
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const darkGrey = Color.fromARGB(255, 96, 99, 103);
const lightGrey = Color.fromARGB(255, 205, 206, 210);
const lightBlue = Color.fromARGB(255, 84, 176, 243);
const white = Color.fromARGB(255, 255, 255, 255);
const darkPurp = Color.fromARGB(255, 60, 7, 93);
const textColor = Color(0xFF535353);
const textLightColor = Color(0xFFACACAC);

// Padding
const defaultPadding = 20.0;

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: const Center(
        child: SpinKitDoubleBounce(
          color: lightBlue,
          size: 100.0,
        ),
      ),
    );
  }
}
