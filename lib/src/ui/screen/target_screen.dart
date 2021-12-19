import 'package:chiyapasal/src/core/res/sizes.dart';
import 'package:chiyapasal/src/core/res/styles.dart';
import 'package:chiyapasal/src/services/other_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../notifier/target_notifier.dart';

class TargetScreen extends StatefulWidget {
  const TargetScreen({Key? key}) : super(key: key);

  @override
  State<TargetScreen> createState() => _TargetScreenState();
}

class _TargetScreenState extends State<TargetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _productTargetController = TextEditingController();
  final _stockTargetController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  _fetchData() async {
    var target = await OtherService().fetchTarget();
    _productTargetController.text = target['product'].toString();
    _stockTargetController.text = target['stock'].toString();
  }

  void _saveData() async {
    if (_formKey.currentState!.validate()) {
      await Provider.of<TargetNotifier>(context, listen: false).setTarget(
          product: int.parse(_productTargetController.text),
          stock: int.parse(_stockTargetController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Target"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.padding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Set Product Target",
                style: boldTitleText,
              ),
              TextFormField(
                controller: _productTargetController,
                keyboardType: TextInputType.number,
                validator: (val) => val!.isEmpty ? 'Please Add Data' : null,
              ),
              const SizedBox(height: 15),
              const Text(
                "Set Stock Target",
                style: boldTitleText,
              ),
              TextFormField(
                controller: _stockTargetController,
                keyboardType: TextInputType.number,
                validator: (val) => val!.isEmpty ? 'Please Add Data' : null,
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                child: const Text("Update"),
                onPressed: _saveData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
