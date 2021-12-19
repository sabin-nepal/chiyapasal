import 'package:chiyapasal/src/core/res/url_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class OtherService{

    static getTarget(){
      var response = FirebaseFirestore.instance.collection(UrlConstant.otherCollection).doc('target').snapshots();
      return response;
    }

}