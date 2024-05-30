import 'package:flutter/material.dart';

class PostScreenAppBar extends StatelessWidget {
  const PostScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back arrow
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(color: Colors.white, blurRadius: 6.0),
                ],
              ),
              child: const Icon(
                Icons.arrow_back_ios,
                size: 28.0,
              ),
            ),
          ),
          // Favourites
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(color: Colors.white, blurRadius: 6.0),
                ],
              ),
              child: const Icon(Icons.favorite, color: Colors.red, size: 28),
            ),
          )
        ],
      ),
    );
  }
}
