import 'package:chiyapasal/src/ui/auction/auction_history.dart';
import 'package:flutter/material.dart';

import '../../ui/auction/update_auction.dart';
import '../../ui/home.dart';

class AppRoutes {
  static const String mainScreen = "main_screen";
  static const String updateAuction = "update_auction";
  static const String auctionHistory = "auction_history";

  static final Map<String, Widget Function(BuildContext)> routes = {
    mainScreen: (_) => const HomePage(),
    updateAuction: (_) => const UpdateAuction(),
  };

  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case auctionHistory:
        Map _data = settings.arguments as Map;
        DateTime _date = _data['date'];
        String _userId = _data['userId'];
        return MaterialPageRoute(
            builder: (_) => AuctionHistory(
                  date: _date,
                  userId: _userId,
                ));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: const Center(
          child: Text("Error"),
        ),
      );
    });
  }
}
