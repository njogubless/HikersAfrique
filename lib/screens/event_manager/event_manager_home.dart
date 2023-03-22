import 'package:flutter/material.dart';
import 'package:hikersafrique/models/event.dart';
import 'package:hikersafrique/screens/event_manager/add_event.dart';
import 'package:hikersafrique/services/database.dart';
import 'package:hikersafrique/screens/post_screen.dart';
import 'package:hikersafrique/widgets/home_appbar.dart';

class EventManagerHome extends StatelessWidget {
  const EventManagerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: CustomHomeAppBar(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEvents(),
            )),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20.0,
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
