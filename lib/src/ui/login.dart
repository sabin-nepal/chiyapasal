import 'package:chiyapasal/src/styles/sizes.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppSizes.padding),
          child: Column(
            children: [
              TextField(),
              TextField(),
              ElevatedButton(
                  onPressed: () {
                    print("hello");
                  },
                  child: const Text("Login"))
            ],
          ),
        ));
  }
}
