import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventRatingPage extends StatefulWidget {
  const EventRatingPage({Key? key}) : super(key: key);

  @override
  _EventRatingPageState createState() => _EventRatingPageState();
}

class _EventRatingPageState extends State<EventRatingPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  Future<String?> _getEventName(String eventId) async {
    final doc = await FirebaseFirestore.instance.collection('events').doc(eventId).get();
    if (doc.exists) {
      return doc['eventName'] as String?;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Ratings'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('rates').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final ratings = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: ratings.length,
                  itemBuilder: (context, index) {
                    final rating = ratings[index];
                    final clientName = rating['clientName'] as String;
                    final comment = rating['comment'] as String;
                    final rateValue = rating['rating'] as double;
                    final eventId = rating['eventId'] as String;

                    return FutureBuilder<String?>(
                      future: _getEventName(eventId),
                      builder: (context, eventSnapshot) {
                        if (eventSnapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        if (!eventSnapshot.hasData) {
                          return const Center(child: Text('Event not found.'));
                        }

                        final eventName = eventSnapshot.data!;

                        if (!_searchQuery.isEmpty &&
                            !clientName.toLowerCase().contains(_searchQuery) &&
                            !comment.toLowerCase().contains(_searchQuery) &&
                            !eventName.toLowerCase().contains(_searchQuery)) {
                          return Container();
                        }

                        return Card(
                          margin: const EdgeInsets.all(8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Event: $eventName',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Client Name: $clientName',
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Text(
                                      'Rating: ',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    Text(
                                      rateValue.toString(),
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Comment: $comment',
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Timestamp: ${rating['timestamp']?.toDate() ?? 'N/A'}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
