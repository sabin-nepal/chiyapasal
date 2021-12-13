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
  @override
  void initState() {
    super.initState();
    _tabPages = [
      const HomeTab(),
      const AuctionTab(),
    ];
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
      bottomNavigationBar: _bottomNavigationBar(context),
      body: IndexedStack(
        children: _tabPages,
        index: _selectedIndex,
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
