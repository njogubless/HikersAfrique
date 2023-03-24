import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class AdminBottomNavBar extends StatefulWidget {
  const AdminBottomNavBar({super.key});

  @override
  State<AdminBottomNavBar> createState() => _AdminBottomNavBarState();
}

class _AdminBottomNavBarState extends State<AdminBottomNavBar> {
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
          Icons.attach_money,
          size: 30.0,
          color: Colors.green,
        ),
        Icon(
          Icons.calendar_month_outlined,
          size: 30.0,
          color: Colors.blue,
        ),
      ],
    );
  }
}
