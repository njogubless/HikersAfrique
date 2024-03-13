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
  List<String> drivers = ['Driver1', 'Driver2', 'Driver3'];
  List<String> guides = ['Guide1', 'Guide2', 'Guide3'];
  Event? selectedEvent;
  String? selectedDriver;
  String? selectedGuide;

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
            DropdownButton<Event>(
              value: selectedEvent,
              onChanged: (Event? value) {
                setState(() {
                  selectedEvent = value;
                });
              },
              items: events.map((Event event) {
                return DropdownMenuItem<Event>(
                  value: event,
                  child: Text(event.name),
                );
              }).toList(),
              hint: const Text('Select Event'),
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedDriver,
              onChanged: (String? value) {
                setState(() {
                  selectedDriver = value;
                });
              },
              items: drivers.map((String driver) {
                return DropdownMenuItem<String>(
                  value: driver,
                  child: Text(driver),
                );
              }).toList(),
              hint: const Text('Select Driver'),
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedGuide,
              onChanged: (String? value) {
                setState(() {
                  selectedGuide = value;
                });
              },
              items: guides.map((String guide) {
                return DropdownMenuItem<String>(
                  value: guide,
                  child: Text(guide),
                );
              }).toList(),
              hint: const Text('Select Guide'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Allocate and store data in Firestore
                if (selectedEvent != null && selectedDriver != null && selectedGuide != null) {
                  allocate(selectedEvent!, selectedDriver!, selectedGuide!);
                } else {
                  // Show error message or handle invalid selection
                }
              },
              child: const Text('Allocate'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> allocate(Event event, String driver, String guide) async {
    // Store allocation data in Firestore
    try {
      await FirebaseFirestore.instance.collection('allocations').add({
        'event': event.name,
        'driver': driver,
        'guide': guide,
      });
      // Show success message or navigate to another page
    } catch (e) {
      // Handle error
      print('Error allocating: $e');
    }
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
