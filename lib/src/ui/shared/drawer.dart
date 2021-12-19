import 'package:chiyapasal/src/core/res/assets.dart';
import 'package:chiyapasal/src/core/res/colors.dart';
import 'package:chiyapasal/src/core/res/route.dart';
import 'package:chiyapasal/src/core/res/styles.dart';
import 'package:chiyapasal/src/notifier/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset(AppAssets.logo),
          ),
          ListTile(
            leading: const Icon(
              Icons.add,
              color: AppColors.primaryColor,
            ),
            title: const Text(
              "Add Product",
              style: boldText,
            ),
            onTap: () => Navigator.pushNamed(context, AppRoutes.addProduct),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: const Icon(
              Icons.track_changes,
              color: AppColors.primaryColor,
            ),
            title: const Text(
              "Target",
              style: boldText,
            ),
            onTap: () => Navigator.pushNamed(context, AppRoutes.target),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: AppColors.primaryColor,
            ),
            onTap: () async {
              await authNotifier.signOut();
            },
            title: const Text(
              "Logout",
              style: boldText,
            ),
          )
        ],
      ),
    );
  }
}
