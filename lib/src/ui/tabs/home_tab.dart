import 'package:chiyapasal/src/core/res/colors.dart';
import 'package:chiyapasal/src/core/res/sizes.dart';
import 'package:chiyapasal/src/core/res/styles.dart';
import 'package:chiyapasal/src/model/product.dart';
import 'package:chiyapasal/src/services/product_service.dart';
import 'package:chiyapasal/src/services/trade_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/trade.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List _tabNames = ['1D', '1W', '1M', '3M', '6M', '1Y'];
  int selectedTabIndex = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 6);
    _tabController.addListener(() {
      selectedTabIndex = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.padding),
        child: Column(children: [
          _buildProductInOut(),
          const SizedBox(
            height: 20,
          ),
          _buildRevuneChart()
        ]));
  }

  Widget _buildProductInOut() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 150,
          width: 150,
          child: Card(
            elevation: 8,
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            color: AppColors.primaryColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Icon(
                  Icons.call_received_outlined,
                  color: Colors.white,
                ),
                const SizedBox(height: 10),
                const Text(
                  "3200",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                const Text("Product In",
                    style: TextStyle(color: Colors.white54))
              ],
            ),
          ),
        ),
        SizedBox(
          height: 150,
          width: 150,
          child: Card(
            elevation: 8,
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            color: AppColors.secondaryColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Icon(
                  Icons.call_made_outlined,
                  color: Colors.white,
                ),
                const SizedBox(height: 10),
                const Text(
                  "3200",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                const Text("Product Out",
                    style: TextStyle(color: Colors.white54))
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRevuneChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabBar(
          controller: _tabController,
          isScrollable: true,
          onTap: (value) {
            setState(() {
              selectedTabIndex = value;
            });
          },
          tabs: _tabNames.map<Widget>((e) {
            return Container(
                padding: const EdgeInsets.all(AppSizes.padding),
                child: Text(
                  e,
                  style: boldText,
                ));
          }).toList(),
        ),
        Container(
          height: 20,
          child: _chart(context)),
      ],
    );
  }

 Widget _chart(BuildContext context) {
   print(selectedTabIndex);
    DateTime date = DateTime.now();
    DateTime startDate;
    DateTime endDate;
    if (selectedTabIndex == 0) {
      startDate = DateTime(date.year, date.month, date.day, 0, 0);
      endDate = DateTime(date.year, date.month, date.day, 23, 59, 59);
    } else if (selectedTabIndex == 1) {
      startDate = DateTime(date.year, date.month, date.day);
      endDate = DateTime(date.year, date.month, date.day + 6);
    } else if (selectedTabIndex == 2) {
      startDate = DateTime(date.year, date.month - 1, date.day);
      endDate = DateTime(date.year, date.month, date.day);
    } else if (selectedTabIndex == 3) {
      startDate = DateTime(date.year, date.month - 3 , date.day);
      endDate = DateTime(date.year, date.month, date.day);
    } else if (selectedTabIndex == 4) {
      startDate = DateTime(date.year, date.month - 6, date.day);
      endDate = DateTime(date.year, date.month, date.day);
    } else {
      startDate = DateTime(date.year - 1, date.month, date.day);
      endDate = DateTime(date.year, date.month, date.day);
    }
    return FutureBuilder<List<QueryDocumentSnapshot<Trade>>>(
      future: TradeService.getTradeByDate(startDate:startDate, endDate:endDate),
      builder: (context,snapshot){
        if(snapshot.hasData){
          return ListView.builder(
            primary: false,
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context,i){
              var data = snapshot.data![i];
              print(data.data().title);
              return Container();
            },
          );
        }
        return Container();
      },
    );
  }
}
