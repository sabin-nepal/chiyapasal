import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/product.dart';

final productRef = FirebaseFirestore.instance.collection("product").withConverter(
      fromFirestore: (snapshot, _) =>
          Product.fromJson(snapshot.id, snapshot.data()!),
      toFirestore: (product, _) => product.toJson(),
    );
