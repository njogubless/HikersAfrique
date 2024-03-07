import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hikersafrique/services/auth.dart';

class Event {
  final String name;

  Event({required this.name});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(name: json['name'] ?? '');
  }
}

class Driver {
  final String id;
  final String name;
  final bool available;

  Driver({required this.id, required this.name, required this.available});
}

class Guide {
  final String id;
  final String name;
  final bool available;

  Guide({required this.id, required this.name, required this.available});
}

class LogisticsPage extends StatelessWidget {
  const LogisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:const PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: LogisticsPageAppBar(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AllocationPage(),
                  ),
                );
              },
              child: const Card(
                margin: EdgeInsets.all(16),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Logistics',
                    style: TextStyle(fontSize: 20),
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

class AllocationPage extends StatefulWidget {
  const AllocationPage({Key? key}) : super(key: key);

  @override
  AllocationPageState createState() => AllocationPageState();
}

class AllocationPageState extends State<AllocationPage> {
  List<Event> events = [];

  @override
  void initState() {
    super.initState();
    fetchEventData();
  }

  void fetchEventData() async {
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('events').get();
    setState(() {
      events = querySnapshot.docs
          .map((doc) => Event(
                name: doc['name'],
              ))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Allocation Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Available Events:',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            FutureBuilder<List<Event>>(
              future: getAvailableEvents(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final event = snapshot.data![index];
                      return ListTile(
                        title: Text(event.name),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Event>> getAvailableEvents() async {
    // Simulating fetching events from a database or API
    await Future.delayed(const Duration(seconds: 2)); // Simulate delay
    return events;
  }
}

class LogisticsPageAppBar extends StatelessWidget {
  const LogisticsPageAppBar({Key? key}) : super(key: key);

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
                  'Logistics Page',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                )
              ],
            ),
            // Logout button
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

