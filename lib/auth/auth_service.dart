import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../db/db_helper.dart';

class AuthService{
  static UserCredential? userCredential;
  static OAuthCredential? oAuthCredential;

  static final _auth = FirebaseAuth.instance;
  static User? get currentUser => _auth.currentUser;

  static Future<bool> loginAdmin(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return DbHelper.isAdmin(credential.user!.uid);
  }
  static Future<bool> loginEmployee(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return DbHelper.isEmployee(credential.user!.uid);
  }
  static Future<bool> register(String email, String password) async {
    userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return userCredential!.user != null;
  }

  static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    // Create a new credential
    oAuthCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(oAuthCredential!);
  }
  static Future<void> logOut(){
    print(_auth.currentUser!.email);
    return _auth.signOut();
  }

  static Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print("Error sending password reset email: $e");
    }
  }

}