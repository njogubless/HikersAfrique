import 'package:flutter/material.dart';

class RestaurantContainer extends StatelessWidget {
  const RestaurantContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 6.0),
          ]),
      child: const Text(
        'Restaurants',
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
      ),
    );
  }
}
