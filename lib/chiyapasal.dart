import 'package:chiyapasal/src/notifier/auth_notifier.dart';
import 'package:chiyapasal/src/ui/editor/home.dart';
import 'package:chiyapasal/src/ui/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthNotifier>(create: (_) => AuthNotifier())
        ],
        child: MaterialApp(
          title: 'Chiya Pasal',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const LoginPage(),
        ));
  }
}
