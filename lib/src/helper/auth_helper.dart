import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthProvider {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<User?> initUser() async{
    User? user = firebaseAuth.currentUser;
    if(user !=null){
      return user;
    }
    return null;
  }

  bool isLogin() {
    if (firebaseAuth.currentUser != null) {
      return true;
    }
    return false;
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
