import 'package:chiyapasal/src/core/res/sizes.dart';
import 'package:chiyapasal/src/core/res/styles.dart';
import 'package:flutter/material.dart';

class TargetScreen extends StatefulWidget {
  
  const TargetScreen({Key? key}) : super(key: key);

  @override
  State<TargetScreen> createState() => _TargetScreenState();
}

class _TargetScreenState extends State<TargetScreen> {
  @override
  Widget build(BuildContext context) {
    final _productTargetController = TextEditingController();
    final _stockTargetController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Target"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Set Product Target",
              style: boldTitleText,
            ),
            TextField(
              controller: _productTargetController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 15),
            const Text(
              "Set Stock Target",
              style: boldTitleText,
            ),
            TextField(
              controller: _stockTargetController,
              keyboardType: TextInputType.number,
            )
          ],
        ),
      ),
    );
  }
}
