import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hikersafrique/models/event.dart';
import 'package:hikersafrique/screens/home/homepages/events_page.dart';
import 'package:hikersafrique/screens/home/homepages/favorites.dart';
import 'package:hikersafrique/screens/post_screen.dart';
import 'package:hikersafrique/widgets/home_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    int _selectedIndex = 0;

  // Selected item function
  void onTappedItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List pages = [
    EventsPage(),
    Favorites(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: CustomHomeAppBar(),
      ),
      drawer: Drawer(
        
      ),
      bottomNavigationBar: CurvedNavigationBar(
      color: Colors.white,
      animationCurve: Curves.bounceOut,
      animationDuration: const Duration(milliseconds: 700),
      buttonBackgroundColor: Colors.white,
      backgroundColor: Colors.transparent,
      onTap: (i)=> onTappedItem(i),
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

      ],
    ),
      body: pages[ _selectedIndex],

    );
  }
}

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

class EventItem extends StatelessWidget {
  const EventItem({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PostScreen(
                            event: event,
                          )));
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Image.network(
                event.eventImageUrl,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  event.eventName,
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.w500),
                ),
                const Icon(
                  Icons.more_vert,
                  size: 30.0,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          const Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.amber,
                size: 20.0,
              ),
              Text(
                '4.5',
                style: TextStyle(fontWeight: FontWeight.w600),
              )
            ],
          )
        ],
      ),
    );
  }
}
