class SavedEvent {
  final String clientID;
  final String eventID;
  const SavedEvent({
    required this.clientID,
    required this.eventID,
  });
  factory SavedEvent.fromJson(Map<String, dynamic> savedEvent) {
    return SavedEvent(
      clientID: savedEvent['clientID'],
      eventID: savedEvent['eventID'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'clientID': clientID,
      'eventID': eventID,
    };
  }
}
