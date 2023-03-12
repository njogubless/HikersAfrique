class Client {
  final String uid;
  final String clientName;
  final String clientEmail;
  bool verified;
  Client({
    required this.uid,
    required this.clientName,
    required this.clientEmail,
    this.verified = false,
  });

  factory Client.fromJson(Map<String, dynamic> client) {
    return Client(
      uid: client['uid'],
      clientName: client['clientName'],
      clientEmail: client['clientEmail'],
      verified: client['verified'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uid': uid,
      'clientName': clientName,
      'clientEmail': clientEmail,
      'verified': verified,
    };
  }
}
