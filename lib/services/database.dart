import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hikersafrique/models/client.dart';
import 'package:hikersafrique/models/event.dart';

class Database {
  // Initialize Firestore
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Save registered client data
  static Future<void> saveClientData(Client client) async {
    final DocumentReference docRef = firestore.collection('clients').doc();
    await docRef.set(client.toJson());
  }

  // Save registered client data
  static Future<Client> getClientData(String email) async {
    final QuerySnapshot querySnapshot = await firestore
        .collection('clients')
        .where('clientEmail', isEqualTo: email)
        .get();
    final List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    return docs
        .map((doc) => Client.fromJson(doc.data() as Map<String, dynamic>))
        .toList()
        .first;
  }

  // Retrieve available events
  static Future<List<Event>> getAvailableEvents() async {
    final QuerySnapshot querySnapshot =
        await firestore.collection('events').get();
    final List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    return docs
        .map((doc) => Event.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  // Save a booked event for a user
  static Future<void> saveBookedEvent(
      String userEmail, String eventName) async {
    final DocumentReference docRef = firestore.collection('bookings').doc();
    await docRef.set({
      'userEmail': userEmail,
      'eventName': eventName,
      'bookingDate': DateTime.now().toIso8601String(),
    });
  }

  // Retrieve a user's booked events
  static Future<List<Map<String, dynamic>>> getBookedEvents(
      String userId) async {
    final QuerySnapshot querySnapshot = await firestore
        .collection('bookings')
        .where('userID', isEqualTo: userId)
        .get();
    final List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    return docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  // Save a saved event for a user
  static Future<void> saveSavedEvent(String userEmail, String eventName) async {
    final DocumentReference docRef = firestore.collection('savedEvents').doc();
    await docRef.set({
      'userEmail': userEmail,
      'eventName': eventName,
    });
  }

  // Retrieve a user's saved events
  static Future<List<Event>> getSavedEvents(String userEmail) async {
    final QuerySnapshot querySnapshot = await firestore
        .collection('savedEvents')
        .where('userEmail', isEqualTo: userEmail)
        .get();
    final List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    List<String> saved = docs.map<String>((doc) {
      final item = doc.data() as Map<String, dynamic>;
      return item['eventName'];
    }).toList();

    final events = await getAvailableEvents();
    return events.where((event) => saved.contains(event.eventName)).toList();
  }

  // Create event
  static Future<void> createEvent(Event event) async {
    final DocumentReference docRef = firestore.collection('events').doc();
    await docRef.set(event.toJson());
  }

  // Edit event
  static Future<void> editEvent(Event event, Event newEvent) async {
    final doc = (await firestore
            .collection('events')
            .where('eventName', isEqualTo: event.eventName)
            .where('eventImageUrl', isEqualTo: event.eventImageUrl)
            .get())
        .docs
        .first;
    await doc.reference.set(newEvent.toJson());
  }
}
