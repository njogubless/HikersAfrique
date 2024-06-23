class Payment {
  final String clientName;
  final double amountPaid;
  final String email;
  final String event;
  final String mpesaCode;
  final double totalCost;
  final String userId;

  String status;
  String? docId;

  Payment({
    this.docId,
    required this.clientName,
    required this.amountPaid,
    required this.totalCost,
    required this.email,
    required this.event,
    required this.mpesaCode,
    required this.status,
    required this.userId,
  });
}
