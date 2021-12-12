import 'package:chiyapasal/src/ui/shared/calendar_view.dart';
import 'package:flutter/material.dart';

class UserView extends StatelessWidget {
  final String userId;
  const UserView({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User View"),
      ),
      body: CustomCalendarView(userId: userId),
    );
  }
}
