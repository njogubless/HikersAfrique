class Client {
  final String uid;
  final String clientName;
  final String clientEmail;
  const Client({
    required this.uid,
    required this.clientName,
    required this.clientEmail,
  });

  factory Client.fromJson(Map<String, dynamic> client) {
    return Client(
      uid: client['uid'],
      clientName: client['clientName'],
      clientEmail: client['clientEmail'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'clientName': clientName,
      'clientEmail': clientEmail,
    };
  }
}
