import 'package:flutter/material.dart';
import 'package:hikersafrique/models/event.dart';
import 'package:hikersafrique/widgets/postscreen_appbar.dart';
import 'package:hikersafrique/widgets/postscreen_navbar.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          event.eventImageUrl,
          fit: BoxFit.fitWidth,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(90.0),
            child: PostScreenAppBar(),
          ),
          bottomNavigationBar: PostScreenNavBar(
            event: event,
          ),
        )
      ],
    );
  }
}
