import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Logistics Page'),
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
      ),
    );
  }
}

class AllocationPage extends StatefulWidget {
  const AllocationPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AllocationPageState createState() => _AllocationPageState();
}

class _AllocationPageState extends State<AllocationPage> {
  List<Event> events = [];
  List<Driver> drivers = [];
  List<Guide> guides = [];

  @override
  void initState() {
    super.initState();
    fetchEventData();
    fetchDriverData();
    fetchGuideData();
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

  void fetchDriverData() async {
    // Add logic to fetch drivers from Firestore
  }

  void fetchGuideData() async {
    // Add logic to fetch guides from Firestore
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
            // Call function to get available events and display them
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
                        onTap: (){
                          // Handle event selection
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Allocate Driver and Guide'),
                                content: const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Select Driver:'),
                                    // Add dropdown to select driver
                                    Text('Select Guide:'),
                                    // Add dropdown to select guide
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Handle allocation logic
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Allocate'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
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

  // Function to get available events
  Future<List<Event>> getAvailableEvents() async {
    // Simulating fetching events from a database or API
    await Future.delayed(const Duration(seconds: 2)); // Simulate delay
    return events;
  }
}
