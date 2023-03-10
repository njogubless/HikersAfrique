import 'package:firebase_auth/firebase_auth.dart';
import 'package:hikersafrique/models/client.dart';
import 'package:hikersafrique/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //to get client from firebase user

  Client? _userFromFirebaseUser(User? user, bool signUp) {
    return user != null
        ? Client(
            uid: user.uid,
            clientName: user.displayName ?? 'User Name',
            clientEmail: user.email!,
            verified: signUp ? false : true,
          )
        : null;
  }

// User stream to listen to auth changes
  Stream<Client?> get user {
    return _auth
        .authStateChanges()
        .map((user) => _userFromFirebaseUser(user, false));
  }

//register with email & password
  Future<Client?> registerWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      // Saved registered user data
      Database.saveClientData(_userFromFirebaseUser(user, true)!);
      return _userFromFirebaseUser(user, true);
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
      return _userFromFirebaseUser(user, false);
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
