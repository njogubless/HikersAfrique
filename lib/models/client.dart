class Client {
  final String uid;
  final String clientName;
  final String clientEmail;
  final String role;
  bool verified;
  Client({
    required this.uid,
    required this.clientName,
    required this.clientEmail,
    required this.role,
    this.verified = false,
  });

  factory Client.fromJson(Map<String, dynamic> client) {
    return Client(
      uid: client['uid'],
      clientName: client['clientName'],
      clientEmail: client['clientEmail'],
      verified: client['verified'],
      role: client['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uid': uid,
      'clientName': clientName,
      'clientEmail': clientEmail,
      'verified': verified,
      'role': role,
    };
  }
}
