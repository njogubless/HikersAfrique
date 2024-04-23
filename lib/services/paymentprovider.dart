// PaymentProvider.dart

import 'package:flutter/material.dart';
import 'package:hikersafrique/screens/finance_manager/payment_model.dart';

class PaymentProvider extends ChangeNotifier {
  List<Payment> payments = [];

  void setPayments(List<Payment> newPayments) {
    payments = newPayments;
    notifyListeners();
  }
}
