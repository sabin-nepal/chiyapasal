import 'package:chiyapasal/src/ui/admin/user_list.dart';
import 'package:chiyapasal/src/ui/admin/user_view.dart';
import 'package:chiyapasal/src/ui/screen/target_screen.dart';
import 'package:chiyapasal/src/ui/screen/update_product.dart';
import 'package:chiyapasal/src/ui/trade/update_trade.dart';
import 'package:flutter/material.dart';
import '../../ui/home.dart';
import '../../ui/screen/add_product.dart';

class AppRoutes {
  static const String mainScreen = "main_screen";
  static const String updateAuction = "update_auction";
  static const String auctionHistory = "auction_history";
  static const String userList = "user_list";
  static const String userView = "user_view";
  static const String addProduct = "add_product";
  static const String updateProduct = "update_product";
  static const String target = "target";

  static final Map<String, Widget Function(BuildContext)> routes = {
    mainScreen: (_) => const HomePage(),
    updateAuction: (_) => const UpdateTrade(),
    userList: (_) => const UserList(),
    addProduct: (_) => const AddProduct(),
    target: (_) => const TargetScreen(),
  };

  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case auctionHistory:
      //   Map _data = settings.arguments as Map;
      //   DateTime _date = _data['date'];
      //   String _userId = _data['userId'];
      //   return MaterialPageRoute(
      //       builder: (_) => AuctionHistory(
      //             date: _date,
      //             userId: _userId,
      //           ));
      case updateProduct:
        Map _data = settings.arguments as Map;
        final _product = _data['product'];
        return MaterialPageRoute(
            builder: (_) => UpdateProduct(
                  product: _product,
                ));
      case userView:
        Map _data = settings.arguments as Map;
        String _userId = _data['userId'];
        return MaterialPageRoute(
            builder: (_) => UserView(
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
