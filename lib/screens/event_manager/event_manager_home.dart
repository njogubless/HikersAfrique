import 'package:flutter/material.dart';
import 'package:hikersafrique/models/event.dart';
import 'package:hikersafrique/screens/event_manager/add_event.dart';
import 'package:hikersafrique/screens/event_manager/edit_event.dart';
import 'package:hikersafrique/screens/home/homepages/feedback.dart';
import 'package:hikersafrique/services/auth.dart';
import 'package:hikersafrique/services/auth_notifier.dart';
import 'package:hikersafrique/services/database.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class EventManagerHome extends StatefulWidget {
  const EventManagerHome({super.key});

  @override
  State<EventManagerHome> createState() => _EventManagerHomeState();
}

class _EventManagerHomeState extends State<EventManagerHome> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthNotifier>(context).user!;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: EventManagerAppBar(),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Image.asset(
                'assets/images/new.jpeg',
                fit: BoxFit.fitWidth,
                height: 150,
                width: double.infinity,
              ),
              ListTile(
                title: Text(
                  user.clientName,
                  style: const TextStyle(
                    fontSize: 30,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  user.clientEmail,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  user.role,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              ListTile(
                  title: const Text(
                    "Contact us",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    launchlink("https://www.hikersafrique.com/");
                    // ignore: unused_local_variable
                  }),
              ListTile(
                  title: const Text(
                    "Feedback",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FeedbackDialog()));
                  }),
              Container(
                height: 100,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.green,
                      Colors.blue,
                      Colors.grey,
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
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
        child: RefreshIndicator(
          onRefresh: () => Future(() => setState(() {})),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 30.0,
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
      ),
    );
  }

  Future launchlink(String link) async {
    try {
      await launchUrl(Uri.parse(link), mode: LaunchMode.externalApplication);
    } catch (error) {
      // ignore: avoid_print
      print(error);
    }
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
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
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
