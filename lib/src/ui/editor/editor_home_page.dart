import 'package:chiyapasal/src/core/res/route.dart';
import 'package:chiyapasal/src/core/res/styles.dart';
import 'package:chiyapasal/src/notifier/auth_notifier.dart';
import 'package:chiyapasal/src/services/trade_service.dart';
import 'package:chiyapasal/src/ui/shared/custom_list_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../core/res/sizes.dart';
import '../../model/trade.dart';

class EditorHomePage extends StatelessWidget {
  const EditorHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chiya Pasal"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await Provider.of<AuthNotifier>(context, listen: false).signOut();
            },
          )
        ],
      ),
      bottomNavigationBar: _bottomButton(context),
      body: Container(
        margin: const EdgeInsets.all(AppSizes.padding),
        child: _sellListing(context),
      ),
    );
  }

  Widget _sellListing(BuildContext context) {
    var userId = Provider.of<AuthNotifier>(context, listen: false).fsUser!.id;
    return StreamBuilder<QuerySnapshot<Trade>>(
        stream: TradeService.getTrade(userId, DateTime.now()),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            var response = snapshot.data!.docs.map((e) => e).toList();
            if (response.isEmpty) {
              return const Center(
                child: Text(
                  "You can see your daily data here. Add Some to view",
                  style: titleText,
                ),
              );
            }
            return ListView.builder(
              itemCount: response.length,
              itemBuilder: (context, i) {
                var data = response[i];
                Trade trade = data.data();
                var time = DateFormat.jm().format(trade.createdAt);
                return CustomListView(
                  title: Text(trade.title),
                  trailing: Text(time.toString()),
                );
              },
            );
          }
          return const Center(
            child: Text(
              "Something went Wrong!! Check Your Internet Connection and try again!!!",
              style: titleText,
            ),
          );
        });
  }

  Widget _bottomButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppSizes.padding),
      width: double.infinity,
      child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.updateAuction);
          },
          child: const Text("Add Log")),
    );
  }
}
