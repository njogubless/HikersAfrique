import 'package:flutter/material.dart';
import 'package:hikersafrique/models/event.dart';
import 'package:hikersafrique/screens/event_manager/edit_event.dart';
import 'package:hikersafrique/services/auth.dart';
import 'package:hikersafrique/services/database.dart';

class EventManagement extends StatefulWidget {
  const EventManagement({super.key});

  @override
  State<EventManagement> createState() => _EventManagementState();
}

class _EventManagementState extends State<EventManagement> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () => Future(() => setState(() {})),
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
                          refresh: () => setState(() {}),
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
    required this.refresh,
  });

  final Event event;
  final VoidCallback refresh;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditEvent(
                      event: event,
                    ))).then((_) => refresh);
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
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
                    Icons.edit,
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
      ),
    );
  }
}

class EventManagerAppBar extends StatelessWidget {
  const EventManagerAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService auth = AuthService();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Sort
            InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6.0,
                      )
                    ],
                    borderRadius: BorderRadius.circular(15.0)),
                child: const Icon(Icons.sort_rounded, size: 28.0),
              ),
            ),
            // Location and City
            const Row(
              children: [
                // Location on icon
                Icon(
                  Icons.supervised_user_circle_rounded,
                  color: Color(0xFFF65959),
                ),
                // City Text
                Text(
                  'Event Manager',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                )
              ],
            ),
            // Search icon
            DropdownButton<int>(
              icon: const Icon(Icons.more_vert),
              underline: const SizedBox.shrink(),
              items: const [
                DropdownMenuItem(
                  value: 1,
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontFamily: 'AvenirNext',
                    ),
                  ),
                ),
              ],
              onChanged: (selection) {
                auth.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
