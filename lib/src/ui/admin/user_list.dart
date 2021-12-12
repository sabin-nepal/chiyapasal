import 'package:chiyapasal/src/core/res/route.dart';
import 'package:chiyapasal/src/core/res/sizes.dart';
import 'package:chiyapasal/src/core/res/styles.dart';
import 'package:chiyapasal/src/notifier/auth_notifier.dart';
import 'package:chiyapasal/src/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/user.dart';

class UserList extends StatelessWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userId = Provider.of<AuthNotifier>(context).fsUser!.id;
    return Scaffold(
      appBar: AppBar(
        title: const Text("User List"),
      ),
      body: Container(
        padding: const EdgeInsets.all(AppSizes.padding),
        child: FutureBuilder<List<User>>(
          future: AuthService().getAllUser(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                itemCount: snapshot.data!.length,
                separatorBuilder: (context, i) => const Divider(),
                itemBuilder: (context, i) {
                  User user = snapshot.data![i];
                  if (user.id == userId) {
                    return Container();
                  }
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(AppRoutes.userView, arguments: {
                        'userId': user.id,
                      });
                    },
                    child: ListTile(
                      title: Text(
                        user.email,
                        style: titleText,
                      ),
                    ),
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
