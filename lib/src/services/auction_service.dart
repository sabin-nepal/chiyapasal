import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/auction.dart';

final auctionRef =
    FirebaseFirestore.instance.collection("auction").withConverter(
          fromFirestore: (snapshot, _) =>
              Auction.fromJson(snapshot.id, snapshot.data()!),
          toFirestore: (auction, _) => auction.toJson(),
        );

class AuctionService {
  static Future<List<QueryDocumentSnapshot<Auction>>> getAuction(
      String userId, DateTime date) async {
    DateTime _start = DateTime(date.year, date.month, date.day, 0, 0);
    DateTime _end = DateTime(date.year, date.month, date.day, 23, 59, 59);
    var response = await auctionRef
        .where("updatedBy", isEqualTo: userId)
        .where('createdAt',
            isGreaterThanOrEqualTo: _start, isLessThanOrEqualTo: _end)
        .orderBy('createdAt', descending: true)
        .get();
    return response.docs.map((e) => e).toList();
  }

  static Future deleteAuction(String id) async {
    await auctionRef.doc(id).delete();
  }
}
