import 'package:chiyapasal/src/core/res/sizes.dart';
import 'package:chiyapasal/src/model/product.dart';
import 'package:chiyapasal/src/model/product_form_data.dart';
import 'package:chiyapasal/src/services/product_service.dart';
import 'package:chiyapasal/src/ui/shared/product_form.dart';
import 'package:flutter/material.dart';

import '../../services/media_service.dart';

class UpdateProduct extends StatefulWidget {
  final Product product;
  const UpdateProduct({Key? key, required this.product}) : super(key: key);

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  late ProductForm _productForm;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _productForm = ProductForm(
      productData: ProductData(
          title: widget.product.title,
          imagePath: widget.product.imagePath,
          income: widget.product.income,
          out: widget.product.out),
      isEdit: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Product"),
      ),
      bottomNavigationBar: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(AppSizes.padding),
              child: ElevatedButton(
                onPressed: _saveData,
                child: const Text("Update"),
              ),
            ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.padding), child: _productForm),
    );
  }

  void _saveData() async {
    var allValid = _productForm.isValid();
    if (allValid) {
      setState(() {
        _isLoading = true;
      });
      ProductData _product = _productForm.productData;
      String? imagePath = _product.imagePath;
      if (_product.image != null) {
        imagePath = await MediaService().uploadFile(_product.image);
      }

      await productRef.doc(widget.product.id).set(Product(
          title: _product.title!,
          imagePath: imagePath!,
          income: _product.income!,
          out: _product.out!,
          createdAt: widget.product.createdAt));
    }
    setState(() {
      _isLoading = false;
    });
  }
}
