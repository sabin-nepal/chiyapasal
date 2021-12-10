import 'package:chiyapasal/src/core/res/route.dart';
import 'package:chiyapasal/src/notifier/auth_notifier.dart';
import 'package:chiyapasal/src/ui/home.dart';
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
          routes: AppRoutes.routes,
          onGenerateRoute: AppRoutes.generateRoute,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const ChiyaPasal(),
        ));
  }
}

class ChiyaPasal extends StatelessWidget {
  const ChiyaPasal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(
      builder: (BuildContext context, AuthNotifier auth, _) {
        if (auth.fsUser!=null) {
          return const HomePage();
        }
        return const LoginPage();
      },
    );
  }
}
