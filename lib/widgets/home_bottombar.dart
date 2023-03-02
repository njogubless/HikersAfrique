import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;

  // Selected item function
  void onTappedItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      color: Colors.white,
      animationCurve: Curves.bounceOut,
      animationDuration: const Duration(milliseconds: 700),
      buttonBackgroundColor: Colors.white,
      backgroundColor: Colors.transparent,
      onTap: onTappedItem,
      index: _selectedIndex,
      items: const [
        Icon(
          Icons.person_outlined,
          size: 30.0,
        ),
        Icon(
          Icons.favorite_outline,
          size: 30.0,
        ),
        Icon(
          Icons.home,
          size: 30.0,
          color: Colors.blue,
        ),
        Icon(
          Icons.location_on_outlined,
          size: 30.0,
        ),
        Icon(
          Icons.list,
          size: 30.0,
        ),
      ],
    );
  }
}
