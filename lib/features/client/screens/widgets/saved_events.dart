import 'package:flutter/material.dart';
import 'package:hikersafrique/models/event.dart';
import 'package:hikersafrique/features/client/screens/post_screens/post_screen.dart';

class SavedEvent extends StatelessWidget {
  const SavedEvent({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PostScreen(
                      event: event,
                    )));
      },
      child: Container(
        height: 160.0,
        margin: const EdgeInsets.only(left: 15.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Stack(
          children: [
            // bookmark icon
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                event.eventImageUrl,
                fit: BoxFit.fitHeight,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: const Color(0xFF000000).withAlpha(100),
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            Container(
              alignment: Alignment.topRight,
              child: const Padding(
                padding: EdgeInsets.only(top: 12, left: 12),
                child: Icon(Icons.bookmark_border_outlined,
                    color: Colors.white, size: 25.0),
              ),
            ),
            const Spacer(),
            // City Name
            Container(
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.only(left: 12),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  event.eventName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}