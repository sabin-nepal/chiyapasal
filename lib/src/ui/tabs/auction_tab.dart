import 'package:chiyapasal/src/core/res/route.dart';
import 'package:chiyapasal/src/notifier/auth_notifier.dart';
import 'package:chiyapasal/src/ui/shared/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/res/sizes.dart';

class AuctionTab extends StatelessWidget {
  const AuctionTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomButton(context),
      body: Container(
        margin: const EdgeInsets.all(AppSizes.padding),
        child: _auctionCalendar(context),
      ),
    );
  }

  Widget _auctionCalendar(BuildContext context) {
    var userId = Provider.of<AuthNotifier>(context, listen: false).fsUser!.id;
    return CustomCalendarView(userId: userId);
  }

  Widget _bottomButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppSizes.padding),
      width: double.infinity,
      child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.updateAuction);
          },
          child: const Text("Add Auction")),
    );
  }
}
