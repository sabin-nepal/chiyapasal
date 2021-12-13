import 'package:chiyapasal/src/core/res/sizes.dart';
import 'package:chiyapasal/src/core/res/styles.dart';
import 'package:chiyapasal/src/notifier/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/trade.dart';
import '../../services/trade_service.dart';

class UpdateTrade extends StatefulWidget {
  const UpdateTrade({Key? key}) : super(key: key);

  @override
  State<UpdateTrade> createState() => _UpdateTradeState();
}

class _UpdateTradeState extends State<UpdateTrade> {
  @override
  void initState() {
    super.initState();
  }

  _showErrorDialog({String? message}) {
    message = message ?? "Enter Title";
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(message!),
          );
        });
  }

  final TextEditingController _titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Trade"),
      ),
      body: Container(
        padding: const EdgeInsets.all(AppSizes.paddingLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Title",
              style: titleText,
            ),
            TextField(
              controller: _titleController,
            ),
            OutlinedButton(
                onPressed: () => _submitAuction(), child: const Text("Update"))
          ],
        ),
      ),
    );
  }

  _submitAuction() async {
    if (_titleController.value.text.isEmpty) {
      return _showErrorDialog();
    }
    Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = _titleController.text;
    data['createdAt'] = DateTime.now();
    final updatedBy =
        Provider.of<AuthNotifier>(context, listen: false).fsUser?.id;
    try {
      await tradeRef.add(Trade(
          title: _titleController.text,
          updatedBy: updatedBy!,
          createdAt: DateTime.now()));
      _titleController.text = "";
    } catch (e) {
      _showErrorDialog(message: "Somethings went wrong");
    }
  }
}
