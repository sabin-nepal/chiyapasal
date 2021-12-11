import 'package:chiyapasal/src/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService{
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future getUser(userid) async{
    var _res = await firestore.collection("users").doc(userid).get();
    if(_res.exists){
      return User.fromJson(userid,_res.data());
    }
    
  }
}