import 'dart:io';

import 'package:chiyapasal/src/model/product.dart';
import 'package:chiyapasal/src/services/media_service.dart';
import 'package:chiyapasal/src/services/product_service.dart';
import 'package:flutter/material.dart';

import '../shared/product_form.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  bool isLoading = false;
  List<ProductForm> products = [
    ProductForm(productData: ProductData(), onDelete: () {})
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: onSaveForm,
          )
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
              addAutomaticKeepAlives: true,
              itemCount: products.length,
              itemBuilder: (_, i) => products[i]),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => onAddForm(),
      ),
    );
  }

  void onDelete(ProductData _productData) {
    setState(() {
      var find = products.firstWhere(
        (it) => it.productData == _productData,
      );
      products.removeAt(products.indexOf(find));
    });
  }

  void onAddForm() {
    setState(() {
      var _productData = ProductData();
      products.add(ProductForm(
        productData: _productData,
        onDelete: () => onDelete(_productData),
      ));
    });
  }

  void onSaveForm() async {
    var allValid = true;
    var createdAt = DateTime.now();
    for (var product in products) {
      allValid = allValid && product.isValid();
    }
    if (allValid) {
      setState(() {
        isLoading = true;
      });
      for (var product in products) {
        var imagePath =
            await MediaService().uploadFile(product.productData.image);
        await productRef.add(Product(
            title: product.productData.title!,
            imagePath: imagePath,
            income: 0,
            outgo: 0,
            createdAt: createdAt));
      }
    }
    setState(() {
      isLoading = false;
    });
  }
}

class ProductData {
  String? title;
  File? image;
  ProductData({this.title, this.image});
}
