import 'package:flutter/material.dart';

import '../../core/res/sizes.dart';

class CustomListView extends StatelessWidget {
  final Widget title;
  final Widget? trailing;
  final Widget? leading;
  const CustomListView({ 
    Key? key,
    required this.title,
    this.leading,
    this.trailing }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppSizes.padding),
      decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: const BorderRadius.all(Radius.circular(AppSizes.padding)),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset: const Offset(0, 3),
      ),
    ],
  ),
      child: ListTile(
        title: title,
        trailing: trailing,
        leading: leading,
      ),
    );
  }
}