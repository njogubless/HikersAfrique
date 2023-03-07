import 'package:cloud_firestore/cloud_firestore.dart';

// Initialize Firestore
final FirebaseFirestore firestore = FirebaseFirestore.instance;

// Retrieve available events
Future<List<Map<String, dynamic>>> getAvailableEvents() async {
  final QuerySnapshot querySnapshot =
      await firestore.collection('events').get();
  final List<QueryDocumentSnapshot> docs = querySnapshot.docs;
  return docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
}

// Save a booked event for a user
Future<void> saveBookedEvent(String userId, String eventId) async {
  final DocumentReference docRef = firestore.collection('bookings').doc();
  await docRef.set({
    'userID': userId,
    'eventID': eventId,
    'bookingDate': DateTime.now().toIso8601String(),
  });
}

// Retrieve a user's booked events
Future<List<Map<String, dynamic>>> getBookedEvents(String userId) async {
  final QuerySnapshot querySnapshot = await firestore
      .collection('bookings')
      .where('userID', isEqualTo: userId)
      .get();
  final List<QueryDocumentSnapshot> docs = querySnapshot.docs;
  return docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
}

// Save a saved event for a user
Future<void> saveSavedEvent(String userId, String eventId) async {
  final DocumentReference docRef = firestore.collection('savedEvents').doc();
  await docRef.set({
    'userID': userId,
    'eventID': eventId,
  });
}

// Retrieve a user's saved events
Future<List<Map<String, dynamic>>> getSavedEvents(String userId) async {
  final QuerySnapshot querySnapshot = await firestore
      .collection('savedEvents')
      .where('userID', isEqualTo: userId)
      .get();
  final List<QueryDocumentSnapshot> docs = querySnapshot.docs;
  return docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
}

// Example usage
void main() async {
  // Retrieve available events
  final List<Map<String, dynamic>> availableEvents = await getAvailableEvents();
  print('Available events:');
  availableEvents.forEach((event) {
    print(
        '- ${event['eventName']} (${event['eventDate']}, ${event['eventTime']})');
  });

  // Save a booked event for a user
  await saveBookedEvent('userID_1', 'eventID_1');

  // Retrieve a user's booked events
  final List<Map<String, dynamic>> bookedEvents =
      await getBookedEvents('userID_1');
  print('Booked events:');
  bookedEvents.forEach((event) {
    print('- ${event['eventID']} (${event['bookingDate']})');
  });

  // Save a saved event for a user
  await saveSavedEvent('userID_1', 'eventID_2');

  // Retrieve a user's saved events
  final List<Map<String, dynamic>> savedEvents =
      await getSavedEvents('userID_1');
  print('Saved events:');
  savedEvents.forEach((event) {
    print('- ${event['eventID']}');
  });
}
