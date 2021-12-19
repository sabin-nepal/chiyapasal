import 'package:chiyapasal/src/core/res/url_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OtherService {
  var firebaseFirestore =
      FirebaseFirestore.instance.collection(UrlConstant.otherCollection);

  Future<void> saveTarget({required int product, required int stock}) async {
    firebaseFirestore
        .doc('target')
        .set({'productTarget': product, 'stockTarget': stock});
  }

  Future fetchTarget() async {
    return firebaseFirestore.doc('target').get();
  }

  Stream getTarget() {
    var response = firebaseFirestore.doc('target').snapshots();
    return response;
  }
}
