class Booking {
  final String clientID;
  final String eventID;
  final String bookingDate;
  const Booking({
    required this.clientID,
    required this.eventID,
    required this.bookingDate,
  });

  factory Booking.fromJson(Map<String, dynamic> booking) {
    return Booking(
      clientID: booking['clientID'],
      eventID: booking['eventID'],
      bookingDate: booking['bookingDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'clientID': clientID,
      'eventID': eventID,
      'bookingDate': bookingDate,
    };
  }
}
