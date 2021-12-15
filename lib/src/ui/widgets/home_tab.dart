import 'package:chiyapasal/src/core/res/colors.dart';
import 'package:chiyapasal/src/core/res/sizes.dart';
import 'package:chiyapasal/src/core/res/styles.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List _tabNames = ['1D', '1W', '1M', '3M', '6M', '1Y'];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 6, initialIndex: 0);
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
          height: 300,
          child: TabBarView(controller: _tabController, children: [
            SfCartesianChart(
              title: ChartTitle(text: "hello"),
            ),
            SfCartesianChart(),
            SfCartesianChart(),
            SfCartesianChart(),
            SfCartesianChart(),
            SfCartesianChart(),
          ]),
        ),
      ],
    );
  }
}
