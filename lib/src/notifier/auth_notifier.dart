import 'package:chiyapasal/src/helper/auth_helper.dart';
import 'package:chiyapasal/src/model/user.dart';
import 'package:chiyapasal/src/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthNotifier extends ChangeNotifier {
  static final _authService = AuthService();
  static final _authProvider = FirebaseAuthProvider();
  late User _fsUser;
  bool get isLoggedin => _authProvider.isLogin();
  User get fsUser => _fsUser;

  AuthNotifier(){
    initUser();
  }

  Future signInWithEmailAndPasword(
      {required String email, required String pasword}) async {
    var user = await _authProvider.signInWithEmailAndPassword(email, pasword);
    _fsUser = await _authService.getUser(user.uid);
    notifyListeners();
  }

  Future initUser() async{
    var user = await _authProvider.initUser();
    _fsUser = await _authService.getUser(user?.uid);
  }

  Future signOut() async {
    _authProvider.signOut();
    notifyListeners();
  }
}
