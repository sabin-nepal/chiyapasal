import 'package:chiyapasal/src/core/res/route.dart';
import 'package:chiyapasal/src/notifier/auth_notifier.dart';
import 'package:chiyapasal/src/notifier/target_notifier.dart';
import 'package:chiyapasal/src/ui/editor/editor_home_page.dart';
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
          ChangeNotifierProvider<AuthNotifier>(create: (_) => AuthNotifier()),
          ChangeNotifierProvider<TargetNotifier>(
            create: (_) => TargetNotifier(),
          )
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
        if (auth.fsUser != null) {
          return _userLoggedIn(context, auth);
        }
        return const LoginPage();
      },
    );
  }

  Widget _userLoggedIn(BuildContext context, AuthNotifier auth) {
    if (auth.fsUser!.isEditor) {
      return const EditorHomePage();
    }
    return const HomePage();
  }
}
