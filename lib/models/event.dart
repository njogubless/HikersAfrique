// ignore_for_file: recursive_getters

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
      eventPackage:event ['eventPackage'] ?? "",
    );
  }

  int get ticketPrice => ticketPrice;

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
}
