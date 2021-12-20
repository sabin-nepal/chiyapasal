import 'package:chiyapasal/src/core/res/url_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/trade.dart';

final tradeRef = FirebaseFirestore.instance
    .collection(UrlConstant.tradeCollection)
    .withConverter(
      fromFirestore: (snapshot, _) =>
          Trade.fromJson(snapshot.id, snapshot.data()!),
      toFirestore: (trade, _) => trade.toJson(),
    );

class TradeService {
  static Future<List<QueryDocumentSnapshot<Trade>>> getTradeList(
      String userId, DateTime date) async {
    DateTime _start = DateTime(date.year, date.month, date.day, 0, 0);
    DateTime _end = DateTime(date.year, date.month, date.day, 23, 59, 59);
    var response = await tradeRef
        .where("updatedBy", isEqualTo: userId)
        .where('createdAt',
            isGreaterThanOrEqualTo: _start, isLessThanOrEqualTo: _end)
        .orderBy('createdAt', descending: true)
        .get();
    return response.docs.map((e) => e).toList();
  }

  static Future<List<QueryDocumentSnapshot<Trade>>> getTradeByDate({
      required DateTime startDate, required DateTime endDate}) async {
    var response = await tradeRef
        .where('createdAt',
            isGreaterThanOrEqualTo: startDate, isLessThanOrEqualTo: endDate)
        .get();
    return response.docs.map((e) => e).toList();
  }

  static Stream<QuerySnapshot<Trade>> getTrade(String userId, DateTime date) {
    DateTime _start = DateTime(date.year, date.month, date.day, 0, 0);
    DateTime _end = DateTime(date.year, date.month, date.day, 23, 59, 59);
    var response = tradeRef
        .where("updatedBy", isEqualTo: userId)
        .where('createdAt',
            isGreaterThanOrEqualTo: _start, isLessThanOrEqualTo: _end)
        .orderBy('createdAt', descending: true)
        .snapshots();
    return response.map((event) => event);
  }

  static Future deleteTrade(String id) async {
    await tradeRef.doc(id).delete();
  }
}
