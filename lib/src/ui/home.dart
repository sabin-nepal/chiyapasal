import 'package:chiyapasal/src/core/res/route.dart';
import 'package:chiyapasal/src/core/res/sizes.dart';
import 'package:chiyapasal/src/core/res/styles.dart';
import 'package:chiyapasal/src/notifier/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/auction_tab.dart';
import 'widgets/home_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> _tabPages = [];
  int _selectedIndex = 0;
  bool _isEditor = true;
  @override
  void initState() {
    super.initState();
    _tabPages = [
      const HomeTab(),
      const AuctionTab(),
    ];
    _isEditor =
        Provider.of<AuthNotifier>(context, listen: false).fsUser!.isEditor;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ChiyaPasal"),
      ),
      drawer: _drawer(context),
      bottomNavigationBar: _bottomNavigationBar(context),
      body: IndexedStack(
        children: _tabPages,
        index: _selectedIndex,
      ),
    );
  }

  Widget _drawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(AppSizes.paddingLg),
        children: [
          DrawerHeader(
            child: Image.asset('assets/chiyapasal.png'),
          ),
          const SizedBox(
            height: 30,
          ),
          if (!_isEditor)
            InkWell(
              child: const Text("User", style: boldText),
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.userList);
              },
            ),
          const SizedBox(
            height: 30,
          ),
          InkWell(
            child: const Text(
              "Logout",
              style: boldText,
            ),
            onTap: () async {
              await Provider.of<AuthNotifier>(context, listen: false).signOut();
            },
          )
        ],
      ),
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.workspaces), label: "Daily Auction"),
      ],
    );
  }
}
