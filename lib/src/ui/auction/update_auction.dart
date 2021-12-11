import 'package:chiyapasal/src/core/res/sizes.dart';
import 'package:chiyapasal/src/core/res/styles.dart';
import 'package:chiyapasal/src/model/auction.dart';
import 'package:chiyapasal/src/notifier/auth_notifier.dart';
import 'package:chiyapasal/src/services/auction_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateAuction extends StatefulWidget {
  const UpdateAuction({Key? key}) : super(key: key);

  @override
  State<UpdateAuction> createState() => _UpdateAuctionState();
}

class _UpdateAuctionState extends State<UpdateAuction> {
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
        title: const Text("Add Auction"),
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
      await auctionRef.add(Auction(
          title: _titleController.text,
          updatedBy: updatedBy!,
          createdAt: DateTime.now()));
      _titleController.text = "";
    } catch (e) {
      _showErrorDialog(message: "Somethings went wrong");
    }
  }
}
