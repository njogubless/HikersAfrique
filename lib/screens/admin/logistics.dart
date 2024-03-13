import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hikersafrique/screens/home/homepages/feedback.dart';
import 'package:hikersafrique/services/auth.dart';
import 'package:hikersafrique/services/auth_notifier.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final user = Provider.of<AuthNotifier>(context).user!;
    return Scaffold(
      appBar:const PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: LogisticsPageAppBar(),
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
                onTap:(){
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
                margin: EdgeInsets.all(30),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    'Logistics',
                    style: TextStyle(fontSize: 28),
                  ),
                ),
              ),
            ),
          ],
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
  List<Event> availableEvents = await getAvailableEvents();
  setState(() {
    events = availableEvents;
  });
}
static Future<List<Event>> getAvailableEvents() async {
  final QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('events').get();
  final List<QueryDocumentSnapshot> docs = querySnapshot.docs;
  return docs
      .map((doc) => Event.fromJson(doc.data() as Map<String, dynamic>))
      .toList();
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
  

  Future<void> recordallocationdata(Event event, String driver, String guide) async {
    // Store allocation data in Firestore
    try {
      await FirebaseFirestore.instance.collection('allocations').add({
        'event': event.name,
        'driver': driver,
        'guide': guide,
      });
      // Show success message or navigate to another page
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Event allocated successfully!')),
      );
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to allocate event: $e')),
      );
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
