import 'package:chiyapasal/src/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../core/res/url_constants.dart';

class AuthService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future getUser(userid) async {
    var _res = await firestore
        .collection(UrlConstant.userCollection)
        .doc(userid)
        .get();
    if (_res.exists) {
      return User.fromJson(userid, _res.data());
    }
  }

  Future<List<User>> getAllUser() async {
    var _res = await firestore.collection(UrlConstant.userCollection).get();
    return _res.docs.map((e) => User.fromJson(e.id, e.data())).toList();
  }
}
