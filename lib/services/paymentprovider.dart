// PaymentProvider.dart

import 'package:flutter/material.dart';
import 'package:hikersafrique/screens/finance_manager/payment_model.dart';

class PaymentProvider extends ChangeNotifier {
  List<Payment> payments = [];

  void setPayments(List<Payment> newPayments) {
    payments = newPayments;
    notifyListeners();
  }

  void approvePayment(Payment payment) {
    // Logic to approve payment
    payment.status = 'approved';
    notifyListeners();
  }

  void rejectPayment(Payment payment) {
    // Logic to reject payment
    payment.status = 'rejected';
    notifyListeners();
  }
}
