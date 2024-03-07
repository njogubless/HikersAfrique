class Payment {
  final String clientName;
  final double amountPaid;
  final String email;
  final String event;
  final String mpesaCode;
  final double totalCost;

  Payment({
    required this.clientName,
    required this.amountPaid,
    required this.totalCost,
    required this.email,
    required this.event,
    required this.mpesaCode,
    //required int totalCost,
  });
}
