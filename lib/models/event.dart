import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String eventID;
  final String eventName;
  final String eventDate;
  final String eventTime;
  final int eventCost;
  final int? totalCost;
  final String eventLocation;
  final String eventImageUrl;
  final String eventDetails;
  final String eventPackage;

  const Event({
    required this.eventID,
    required this.eventName,
    required this.eventDate,
    required this.eventTime,
    required this.eventCost,
    required this.totalCost,
    required this.eventLocation,
    required this.eventImageUrl,
    required this.eventDetails,
    required this.eventPackage,
  });

  factory Event.fromJson(Map<String, dynamic> event) {
    return Event(
      eventID: event['eventID'],
      eventName: event['eventName'],
      eventDate: event['eventDate'],
      eventTime: event['eventTime'],
      eventCost: event['eventCost'],
      totalCost: event['totalCost'],
      eventLocation: event['eventLocation'],
      eventImageUrl: event['eventImageUrl'],
      eventDetails: event['eventDetails'] ?? "",
      eventPackage: event['eventPackage'] ?? "",
    );
  }

  factory Event.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Event(
      eventID: doc.id,
      eventName: data['eventName'],
      eventDate: data['eventDate'],
      eventTime: data['eventTime'],
      eventCost: data['eventCost'],
      totalCost: data['totalCost'],
      eventLocation: data['eventLocation'],
      eventImageUrl: data['eventImageUrl'],
      eventDetails: data['eventDetails'] ?? "",
      eventPackage: data['eventPackage'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'eventID': eventID,
      'eventName': eventName,
      'eventDate': eventDate,
      'eventTime': eventTime,
      'eventCost': eventCost,
      'totalCost': totalCost,
      'eventLocation': eventLocation,
      'eventImageUrl': eventImageUrl,
      'eventDetails': eventDetails,
      'eventPackage': eventPackage,
    };
  }

  int get ticketPrice => eventCost; // Fixing the recursive getter issue
}
