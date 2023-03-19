import 'package:flutter/material.dart';
import 'package:hikersafrique/models/client.dart';

class AuthNotifier extends ChangeNotifier {
  Client? _user;

  Client? get user => _user;

  void setUser(Client user) {
    _user = user;
    notifyListeners();
  }
}
