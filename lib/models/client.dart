class Client {
  final String uid;
  final String clientName;
  final String clientEmail;
  final String role;
  String status;
  Client({
    required this.uid,
    required this.clientName,
    required this.clientEmail,
    required this.role,
    this.status = 'Pending',
  });

  factory Client.fromJson(Map<String, dynamic> client) {
    return Client(
      uid: client['uid'],
      clientName: client['clientName'],
      clientEmail: client['clientEmail'],
      status: client['status'],
      role: client['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uid': uid,
      'clientName': clientName,
      'clientEmail': clientEmail,
      'status': status,
      'role': role,
    };
  }
}
