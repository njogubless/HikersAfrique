import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:hikersafrique/models/userclient.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //to get client from firebase user

  Client _userFromFirebaseUser(User user) {
    return Client(uid: user.uid);
  }

//register with email & password
  Future<Client?> registerWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      return _userFromFirebaseUser(user);
    } catch (e) {
      return null;
    }
  }

  //sign in with email & password
  Future<Client?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      return _userFromFirebaseUser(user);
    } catch (e) {
      return null;
    }
  }

  // Sign out Method
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
