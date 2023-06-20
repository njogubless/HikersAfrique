import 'package:flutter/material.dart';
import 'package:hikersafrique/models/event.dart';
import 'package:hikersafrique/widgets/postscreen_appbar.dart';
import 'package:hikersafrique/widgets/postscreen_navbar.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: PostScreenAppBar(),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Center(
            child: Image.network(
              event.eventImageUrl,
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
      ),
      bottomNavigationBar: PostScreenNavBar(
        event: event,
      ),
    );
  }
}
