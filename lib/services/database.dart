import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hikersafrique/models/client.dart';

class Database {
  // Initialize Firestore
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Save registered client data
  static Future<void> saveClientData(Client client) async {
    final DocumentReference docRef = firestore.collection('clients').doc();
    await docRef.set(client.toJson());
  }

// Retrieve available events
  static Future<List<Map<String, dynamic>>> getAvailableEvents() async {
    final QuerySnapshot querySnapshot =
        await firestore.collection('events').get();
    final List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    return docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

// Save a booked event for a user
  static Future<void> saveBookedEvent(String userId, String eventId) async {
    final DocumentReference docRef = firestore.collection('bookings').doc();
    await docRef.set({
      'userID': userId,
      'eventID': eventId,
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
  static Future<void> saveSavedEvent(String userId, String eventId) async {
    final DocumentReference docRef = firestore.collection('savedEvents').doc();
    await docRef.set({
      'userID': userId,
      'eventID': eventId,
    });
  }

// Retrieve a user's saved events
  static Future<List<Map<String, dynamic>>> getSavedEvents(
      String userId) async {
    final QuerySnapshot querySnapshot = await firestore
        .collection('savedEvents')
        .where('userID', isEqualTo: userId)
        .get();
    final List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    return docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }
}
