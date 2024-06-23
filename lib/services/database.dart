import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hikersafrique/models/client.dart';
import 'package:hikersafrique/models/event.dart';
import 'package:hikersafrique/screens/finance_manager/payment_model.dart';

class Database {
  // Initialize Firestore
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Fetch payments from Firestore
  static Future<List<Payment>> getrecordPayments() async {
    try {
      QuerySnapshot querySnapshot =
          await firestore.collection('payments').get();

      List<Payment> payments = [];

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        String clientName = doc['clientName'];
        double amountPaid = doc['amountPaid'].toDouble();
        double totalCost = doc['totalCost'].toDouble();
        String email = doc['email'];
        String event = doc['event'];
        String mpesaCode = doc['mpesaCode'];
        String docId = doc['id'];

        Payment payment = Payment(
          docId: docId,
          clientName: clientName,
          amountPaid: amountPaid,
          email: email,
          event: event,
          mpesaCode: mpesaCode,
          totalCost: totalCost,
          status: doc['status'] ?? '',
          userId: 'UserId',
        );

        payments.add(payment);
      }

      return payments;
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching payments: $e');
      return [];
    }
  }

  static Future<void> recordPayments(List<Payment> payments) async {
    try {
      final CollectionReference paymentCollection =
          FirebaseFirestore.instance.collection('payments');

      // Loop through the payments and set each one to Firestore
      for (var payment in payments) {
        final DocumentReference docRef =
            paymentCollection.doc(); // Get a new document reference
        await docRef.set({
          'id': docRef.id,
          'clientName': payment.clientName,
          'amountPaid': payment.amountPaid,
          'totalCost': payment.totalCost,
          'email': payment.email,
          'event': payment.event,
          'mpesaCode': payment.mpesaCode,
          'status': payment.status,
        });
      }
      debugPrint('Payments added successfully to Firestore');
    } catch (e) {
      debugPrint('Error adding payments to Firestore: $e');
    }
  }

//updating payment status
  static Future<void> updatePaymentStatus(
      String paymentId, String status) async {
    try {
      await FirebaseFirestore.instance
          .collection('payments')
          .doc(paymentId)
          .update({'status': status});
    } catch (e) {
      debugPrint('Error updating payment status: $e');
      rethrow;
    }
  }

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

  // Retrieve pending clients
  static Future<List<Client>> getClients() async {
    final QuerySnapshot querySnapshot =
        await firestore.collection('clients').get();
    final List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    return docs
        .map((doc) => Client.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  // Verify clients
  static Future<void> verifyser(Client client) async {
    final QuerySnapshot querySnapshot = await firestore
        .collection('clients')
        .where('clientEmail', isEqualTo: client.clientEmail)
        .get();
    await querySnapshot.docs.first.reference.update({'status': 'Verified'});
  }

  // Retrieve pending clients
  static Future<void> revokeUser(Client client) async {
    final QuerySnapshot querySnapshot = await firestore
        .collection('clients')
        .where('status', isEqualTo: 'Verified')
        .where('clientEmail', isEqualTo: client.clientEmail)
        .get();
    await querySnapshot.docs.first.reference.update({'status': 'Rejected'});
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

  static Future<void> recordAllocationData(
      Event event, String driver, String guide) async {
    try {
      await FirebaseFirestore.instance.collection('allocations').add({
        'event': event.eventName,
        'driver': driver,
        'guide': guide,
      });
    } catch (e) {
      throw Exception('Error recording allocation: $e');
    }
  }

  // Save a booked event for a user
  static Future<void> saveBookedEvent(String userEmail, String eventID) async {
    final DocumentReference docRef = firestore.collection('bookings').doc();
    await docRef.set({
      'userEmail': userEmail,
      'eventID': eventID,
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
  static Future<void> saveSavedEvent(String userEmail, String eventID) async {
    final DocumentReference docRef = firestore.collection('savedEvents').doc();
    await docRef.set({
      'userEmail': userEmail,
      'eventID': eventID,
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
      return item['eventID'];
    }).toList();

    final events = await getAvailableEvents();
    return events.where((event) => saved.contains(event.eventID)).toList();
  }

  // Create event
  static Future<void> createEvent(
    Event event,
  ) async {
    final DocumentReference docRef = firestore.collection('events').doc();
    await docRef.set(event.toJson());
  }

  // Edit event
  static Future<void> editEvent(Event event, Event newEvent) async {
    final doc = (await firestore
            .collection('events')
            .where('eventID', isEqualTo: event.eventID)
            .get())
        .docs
        .first;
    await doc.reference.set(newEvent.toJson());
  }

  static Future<int> getNumberBooked(String eventID) async {
    final result = await firestore
        .collection('bookings')
        .where('eventID', isEqualTo: eventID)
        .count()
        .get();
    return result.count;
  }

  static Future<int> getNumberOfEvents() async {
    final result = await firestore.collection('events').count().get();
    return result.count;
  }

  //deleting an event
  static Future<void> deleteEvent(Event event) async {
    try {
      // Assuming you have a reference to your database collection
      // and the events are stored under an 'events' collection
      final eventRef = (await firestore
              .collection('events')
              .where(
                'eventID',
                isEqualTo: event.eventID,
              )
              .get())
          .docs
          .first
          .reference;

      // Delete the document
      await eventRef.delete();

      // Delete the event's corresponding bookings
      final bookingQuerySnapshot = await firestore
          .collection('bookings')
          .where('eventID', isEqualTo: event.eventID)
          .get();
      final bookingDocs = bookingQuerySnapshot.docs;
      for (final doc in bookingDocs) {
        await doc.reference.delete();
      }

      // Delete the event from savedEvents
      final savedQuerySnapshot = await firestore
          .collection('savedEvents')
          .where('eventID', isEqualTo: event.eventID)
          .get();
      final savedDocs = savedQuerySnapshot.docs;
      for (final doc in savedDocs) {
        await doc.reference.delete();
      }
    } catch (e) {
      // Handle any errors that occur during the deletion process
      debugPrint('Error deleting event: $e');
    }
  }

  // Retrieve available events
  static Future<int> getTotalRevenue() async {
    int total = 0;
    final QuerySnapshot querySnapshot =
        await firestore.collection('events').get();
    final List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    final events = docs
        .map((doc) => Event.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    for (final event in events) {
      total += event.eventCost * await getNumberBooked(event.eventID);
    }
    return total;
  }
}
