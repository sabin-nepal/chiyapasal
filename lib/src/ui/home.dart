import 'package:chiyapasal/src/ui/shared/drawer.dart';
import 'package:flutter/material.dart';
import 'tabs/auction_tab.dart';
import 'tabs/home_tab.dart';
import 'tabs/product_tab.dart';

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
      const ProductTab(),
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
      drawer: const DrawerMenu(),
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
            icon: Icon(Icons.production_quantity_limits), label: "Product"),
      ],
    );
  }
}
