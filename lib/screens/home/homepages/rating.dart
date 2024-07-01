import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hikersafrique/models/event.dart';

class Rating extends StatefulWidget {
  const Rating({Key? key}) : super(key: key);

  @override
  RatingState createState() => RatingState();
}

class RatingState extends State<Rating> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  double _rating = 1.0; // Initialize to a valid value within the range

  @override
  void initState() {
    super.initState();
  }

  Future<void> _submitRatingAndComment(Event event) async {
    if (_rating > 0 && _commentController.text.isNotEmpty && _nameController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Submitting rating and comment...')),
      );

      try {
        await FirebaseFirestore.instance.collection('rates').add({
          'eventId': event.eventID,
          'clientName': _nameController.text,
          'rating': _rating,
          'comment': _commentController.text,
          'timestamp': FieldValue.serverTimestamp(),
        });

        setState(() {
          _rating = 1.0; // Reset to a valid value
          _nameController.clear();
          _commentController.clear();
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Rating and comment submitted!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to submit rating and comment.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please provide a name, rating, and comment.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rate Events'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('events').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final events = snapshot.data!.docs.map((doc) {
            return Event.fromSnapshot(doc);
          }).toList();

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.eventName,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Image.network(event.eventImageUrl),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter your name here',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Slider(
                        value: _rating,
                        min: 1,
                        max: 10,
                        divisions: 9,
                        label: _rating.toString(),
                        onChanged: (value) {
                          setState(() {
                            _rating = value;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _commentController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter your comment here',
                        ),
                        maxLines: 4,
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () => _submitRatingAndComment(event),
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
