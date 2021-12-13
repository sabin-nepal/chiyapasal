import 'package:chiyapasal/src/core/res/colors.dart';
import 'package:chiyapasal/src/core/res/sizes.dart';
import 'package:chiyapasal/src/core/res/styles.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.padding),
      child: Row(
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
                  const SizedBox(height:20),
                  const Icon(
                    Icons.call_received_outlined,
                    color: Colors.white,
                  ),
                  const SizedBox(height:10),
                  const Text(
                    "3200",
                    style: TextStyle(color: Colors.white,fontSize: 15),
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
                  const SizedBox(height:20),
                  const Icon(
                    Icons.call_made_outlined,
                    color: Colors.white,
                  ),
                  const SizedBox(height:10),
                  const Text(
                    "3200",
                    style: TextStyle(color: Colors.white,fontSize: 15),
                  ),
                  const Text("Product Out",
                      style: TextStyle(color: Colors.white54))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
