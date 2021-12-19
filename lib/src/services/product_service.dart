import 'package:chiyapasal/src/core/res/url_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/product.dart';

final productRef =
    FirebaseFirestore.instance.collection(UrlConstant.productCollection).withConverter(
          fromFirestore: (snapshot, _) =>
              Product.fromJson(snapshot.id, snapshot.data()!),
          toFirestore: (product, _) => product.toJson(),
        );

class ProductService {
  static Stream<QuerySnapshot<Product>> getProduct() {
    var response =
        productRef.orderBy('createdAt', descending: true).snapshots();
    return response.map((event) => event);
  }
}
