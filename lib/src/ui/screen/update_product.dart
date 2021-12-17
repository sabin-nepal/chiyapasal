import 'package:chiyapasal/src/core/res/sizes.dart';
import 'package:chiyapasal/src/model/product.dart';
import 'package:chiyapasal/src/model/product_form_data.dart';
import 'package:chiyapasal/src/ui/shared/product_form.dart';
import 'package:flutter/material.dart';

class UpdateProduct extends StatefulWidget {
  final Product product;
  const UpdateProduct({Key? key, required this.product}) : super(key: key);

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Product"),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.padding),
          child: ProductForm(
            productData: ProductData(
              title: widget.product.title,
              imagePath: widget.product.imagePath,
              income: widget.product.income,
              out: widget.product.out,
            ),
            isEdit: true,
          )),
    );
  }
}
