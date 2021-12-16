import 'package:chiyapasal/src/core/res/assets.dart';
import 'package:chiyapasal/src/core/res/route.dart';
import 'package:chiyapasal/src/notifier/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context,listen: false);
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset(AppAssets.logo),
          ),

          GestureDetector(
            child: const Text("Add Product"),
            onTap: ()=> Navigator.pushNamed(context, AppRoutes.addProduct),
          ),
            
          GestureDetector(
            onTap: () async{
              await authNotifier.signOut();
            },
            child: const Text("Logout"),
          )
        ],
      ),
    );
  }
}