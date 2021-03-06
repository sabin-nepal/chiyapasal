import 'package:chiyapasal/src/core/res/colors.dart';
import 'package:chiyapasal/src/core/res/route.dart';
import 'package:chiyapasal/src/core/res/sizes.dart';
import 'package:chiyapasal/src/core/res/styles.dart';
import 'package:chiyapasal/src/notifier/target_notifier.dart';
import 'package:chiyapasal/src/services/product_service.dart';
import 'package:chiyapasal/src/ui/shared/product_list_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/product.dart';

class ProductTab extends StatelessWidget {
  const ProductTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Product>>(
      stream: ProductService.getProduct(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var response = snapshot.data!.docs.map((e) => e).toList();
          return Padding(
            padding: const EdgeInsets.all(AppSizes.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInoutData(context, response),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Products List",
                  style: boldTitleText,
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(child: _productList(context, response)),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  _buildInoutData(
      BuildContext context, List<QueryDocumentSnapshot<Product>> response) {
    var income = 0;
    double productRatio = 0;
    double stockRatio = 0;
    for (var e in response) {
      income += e.data().income;
    }
    return Consumer<TargetNotifier>(builder: (context, target, _) {
      if (target.target != null) {
        productRatio = (response.length / target.target['product']) * 100;
        stockRatio = (income / target.target['stock']) * 100;
      }
      return Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Total Products",
                style: boldTitleText,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                response.length.toString(),
                style: boldText,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor.withOpacity(0.1),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColor,
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: AppColors.secondaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.arrow_upward,
                          color: AppColors.bgWhiteColor,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      productRatio.toString(),
                      style: const TextStyle(
                          color: AppColors.secondaryColor, fontSize: 12),
                    ),
                    const SizedBox(
                      width: 7,
                    )
                  ],
                ),
              )
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Stock In Hand",
                  style: boldTitleText,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  income.toString(),
                  style: boldText,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.arrow_upward,
                            color: AppColors.bgWhiteColor,
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${stockRatio.toString()} %',
                        style: const TextStyle(
                            color: AppColors.primaryColor, fontSize: 12),
                      ),
                      const SizedBox(
                        width: 7,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _productList(BuildContext context, dynamic response) {
    return ListView.builder(
      primary: false,
      itemCount: response.length,
      itemBuilder: (_, i) {
        var data = response[i];
        Product product = data.data();
        return InkWell(
          onTap: () => Navigator.pushNamed(context, AppRoutes.updateProduct,
              arguments: {'product': product}),
          child: ProductListView(
            product: product,
          ),
        );
      },
    );
  }
}
