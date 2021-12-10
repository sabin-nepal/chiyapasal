import 'package:flutter/material.dart';

import '../../ui/home.dart';

class AppRoutes{
  static const String mainScreen = "main_screen";
  
  static final Map<String, Widget Function(BuildContext)> routes = {
    mainScreen: (_) => const HomePage(),
  };

  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case fullMedia:
      //   Map _data = settings.arguments as Map;
      //   String _url = _data['url'];
      //   String _type = _data['type'] ?? 'image';
      //   return MaterialPageRoute(
      //       builder: (_) => FullMediaView(
      //             url: _url,
      //             type: _type,
      //           ));
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