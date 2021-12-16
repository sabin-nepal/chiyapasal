import 'package:flutter/material.dart';

import '../shared/product_form.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List product = [1];
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
      body: ListView.builder(
          itemCount: product.length,
          itemBuilder: (context, i) {
            return ProductForm(
              onDelete: () => onDelete(i),
              imagePath: (val) {},
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: onAddForm,
      ),
    );
  }

  void onDelete(int index) {
    setState(() {
      product.removeAt(index);
    });
  }

  void onAddForm() {
    setState(() {
      product.add(1);
    });
  }

  void onSaveForm() {}
}
