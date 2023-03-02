import 'package:flutter/material.dart';
import 'package:hikersafrique/widgets/postscreen_appbar.dart';
import 'package:hikersafrique/widgets/postscreen_navbar.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'images/milan2.jpg',
              ),
              fit: BoxFit.fill,
              opacity: 0.8),
        ),
        child: const Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(90.0),
            child: PostScreenAppBar(),
          ),
          bottomNavigationBar: PostScreenNavBar(),
        ));
  }
}
