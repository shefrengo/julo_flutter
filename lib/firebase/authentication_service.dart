import 'package:firebase_auth/firebase_auth.dart';


class AuthenticationService {
  final FirebaseAuth auth;
  Stream<User> get authStateChange => auth.authStateChanges();
  Future<void> signOut() async {
    await auth.signOut();
  }

  AuthenticationService(this.auth);
  Future signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.message.toString());
    }
  }

  Future signUp(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }
}
