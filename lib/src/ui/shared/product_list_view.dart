import 'package:chiyapasal/src/core/res/styles.dart';
import 'package:flutter/material.dart';

import '../../core/res/colors.dart';
import '../../core/res/sizes.dart';
import '../../model/product.dart';

class ProductListView extends StatelessWidget {
  final Product product;
  const ProductListView({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.all(AppSizes.padding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 60,
              child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor.withOpacity(0.1)),
                  height: 60,
                  child: Center(
                      child: Image.network(
                    product.imagePath,
                    height: 40,
                  )))),
          const Spacer(),
          SizedBox(
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        product.title,
                        style: titleText,
                      ),
                      const Spacer(),
                      if (product.income <= product.out)
                        const Text(
                          "Low Stock",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w300),
                        )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.arrow_drop_up,
                        color: Colors.green,
                      ),
                      Text(product.income.toString()),
                      const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.red,
                      ),
                      Text(product.out.toString()),
                    ],
                  )
                ],
              )),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(
              width: 20,
              child: Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
    );
  }
}
