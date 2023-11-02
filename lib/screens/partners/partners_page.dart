import 'package:flutter/material.dart';
import 'package:hikersafrique/models/event.dart';
import 'package:hikersafrique/services/auth.dart';
import 'package:hikersafrique/services/database.dart';

class PartnersPage extends StatelessWidget {
  final AuthService _auth = AuthService();

  PartnersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Partners'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              await _auth.signOut(); // Sign out when the user taps the exit button
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Event>>(
        future: Database.getAvailableEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No events available.'));
          } else {
            List<Event> events = snapshot.data!;
            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (BuildContext context, int index) {
                Event event = events[index];
                return PartnerEventItem(event: event);
              },
            );
          }
        },
      ),
    );
  }
}

class PartnerEventItem extends StatelessWidget {
  final Event event;

  const PartnerEventItem({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(event.eventName),
      subtitle: Text('Date: ${event.eventDate.toString()}'),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PartnerConfirmationPage(
              event: event)),
        );
      },
    );
  }
}

class PartnerConfirmationPage extends StatelessWidget {
  final Event event;

  const PartnerConfirmationPage({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Implement the UI for partner confirmation page
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Partnership'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Event: ${event.eventName}',
              style: const TextStyle(fontSize: 20),
            ),
            // Add more UI elements for partner confirmation, e.g., checkboxes, buttons, etc.
          ],
        ),
      ),
    );
  }
}
