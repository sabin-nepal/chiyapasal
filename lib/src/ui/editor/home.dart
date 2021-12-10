import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../notifier/auth_notifier.dart';

class EditorHome extends StatelessWidget {
  const EditorHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ChiyaPasal"),
      ),
      body: ElevatedButton(
          onPressed: () async {
            await Provider.of<AuthNotifier>(context, listen: false).signOut();
          },
          child: const Text("Logout Editor")),
    );
  }
}
