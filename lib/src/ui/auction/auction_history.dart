import 'package:chiyapasal/src/core/res/sizes.dart';
import 'package:chiyapasal/src/core/res/styles.dart';
import 'package:chiyapasal/src/services/auction_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/auction.dart';

class AuctionHistory extends StatefulWidget {
  final DateTime date;
  final String userId;
  const AuctionHistory({Key? key, required this.date, required this.userId})
      : super(key: key);

  @override
  State<AuctionHistory> createState() => _AuctionHistoryState();
}

class _AuctionHistoryState extends State<AuctionHistory> {
  dynamic day;
  dynamic _date;
@override
  void initState() {
    super.initState();
    day = DateFormat('EEEE').format(widget.date);
    _date = DateFormat('MMMM dd, yyyy').format(widget.date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Auction"),
      ),
      body: Container(
          padding: const EdgeInsets.all(AppSizes.padding),
          child: Column(
            children: [
              SizedBox(
                height: 30,
                child: Column(
                  children: [
                    Text(day,style: boldText,),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
                child: Text(_date.toString(),style: titleText,),
              ),
              Expanded(child: _auctionListing())
            ],
          )),
    );
  }

  Widget _auctionListing() {
    return FutureBuilder<List<QueryDocumentSnapshot<Auction>>>(
      future: AuctionService.getAuction(widget.userId, widget.date),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return ListView.separated(
            primary: false,
            itemCount: snapshot.data!.length,
            separatorBuilder: (context, i) => const Divider(),
            itemBuilder: (context, i) {
              Auction data = snapshot.data![i].data();
              var time = DateFormat.jm().format(data.createdAt);
              return ListTile(
                leading: Text(time.toString()),
                title: Center(child: Text(data.title)),
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
