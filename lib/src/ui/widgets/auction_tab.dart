import 'package:flutter/material.dart';

import '../../core/res/sizes.dart';

class AuctionTab extends StatelessWidget {
  const AuctionTab({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomButton(),
      body: Container(
        margin: const EdgeInsets.all(AppSizes.padding),
        child: _auctionListing(),
      ),
    );
  }

  Widget _auctionListing(){
    return Container();
  }

  Widget _bottomButton(){
    return Container(
      margin: const EdgeInsets.all(AppSizes.padding),
      width: double.infinity,
      child: ElevatedButton(onPressed: (){

      }, child: const Text("Add Log")),
    );
  }
}