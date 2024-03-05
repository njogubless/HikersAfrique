import 'package:flutter/material.dart';
import 'package:hikersafrique/models/event.dart';
import 'package:hikersafrique/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PartnersPage extends StatelessWidget {
  const PartnersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Partners'),
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
      subtitle: Text(
          'Date: ${event.eventDate.toString()}'), // You can display event details here
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PartnerConfirmationPage(event: event)),
        );
      },
    );
  }
}

class PartnerConfirmationPage extends StatefulWidget {
  final Event event;

  const PartnerConfirmationPage({Key? key, required this.event})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PartnerConfirmationPageState createState() =>
      _PartnerConfirmationPageState();
}

class _PartnerConfirmationPageState extends State<PartnerConfirmationPage> {
  String _selectedPartnerType = 'Sponsor'; // Default partner type
  final TextEditingController _partnerNameController = TextEditingController();

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();


  @override
  void dispose() {
    _partnerNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Partnership'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Event: ${widget.event.eventName}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              const Text(
                'Select Partner Type:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              DropdownButton<String>(
                value: _selectedPartnerType,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedPartnerType = newValue!;
                  });
                },
                items: <String>['Sponsor', 'Event Company', 'Hotel']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _partnerNameController,
                decoration: const InputDecoration(
                  labelText: 'Partner Name',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Implement logic to save partner type and name to database
                  try {
                    await FirebaseFirestore.instance
                        .collection('partnerships')
                        .add({
                      'eventId': widget.event.eventID,
                      'partnerName': _partnerNameController.text,
                      'partnerType': _selectedPartnerType,
                      'timestamp': FieldValue.serverTimestamp(),
                    });
                  _scaffoldKey.currentState?.showSnackBar(const SnackBar(
                        content: Text('Partnership confirmed successfully'),
                      ));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error confirming partnership: $e'),
                      ),
                    );
                  }
                },
                child: const Text('Confirm Partnership'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
