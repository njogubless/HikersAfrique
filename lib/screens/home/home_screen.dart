import 'package:flutter/material.dart';
import 'package:hikersafrique/models/event.dart';
import 'package:hikersafrique/services/auth_notifier.dart';
import 'package:hikersafrique/services/database.dart';
import 'package:hikersafrique/items/best_places.dart';
import 'package:hikersafrique/items/favourites.dart';
import 'package:hikersafrique/items/hotels.dart';
import 'package:hikersafrique/items/most_visited.dart';
import 'package:hikersafrique/items/new_added.dart';
import 'package:hikersafrique/items/restaurants.dart';
import 'package:hikersafrique/screens/post_screen.dart';
import 'package:hikersafrique/widgets/home_appbar.dart';
import 'package:hikersafrique/widgets/home_bottombar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: CustomHomeAppBar(),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => Future(() => setState(() {})),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 200.0,
                        child: FutureBuilder<List<Event>>(
                            future: Database.getSavedEvents(
                                Provider.of<AuthNotifier>(context)
                                    .user!
                                    .clientEmail),
                            initialData: const [],
                            builder: (context, snapshot) {
                              return ListView.builder(
                                padding: const EdgeInsets.only(right: 20),
                                itemCount: snapshot.data!.length,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context, int index) {
                                  return SavedEvent(
                                    event: snapshot.data![index],
                                  );
                                },
                              );
                            }),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                // Category of best places,most visited etc
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: const [
                        // BestPlaces Container
                        BestPlacesContainer(),
                        // Most Visited Container
                        MostVisitedContainer(),
                        //Favourites Container
                        FavouriteContainer(),
                        // New Added Container
                        NewAddedContainer(),
                        // Hotels Container
                        HotelsContainer(),
                        // Restaurants Container
                        RestaurantContainer(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                FutureBuilder<List<Event>>(
                    future: Database.getAvailableEvents(),
                    initialData: const [],
                    builder: (context, snapshot) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, index) {
                          return EventItem(
                            event: snapshot.data![index],
                          );
                        },
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
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
          Row(
            children: const [
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
