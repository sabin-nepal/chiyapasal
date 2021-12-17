import 'dart:io';

import 'package:chiyapasal/src/core/res/sizes.dart';
import 'package:chiyapasal/src/core/res/styles.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/product_form_data.dart';

typedef OnDelete = Function();

class ProductForm extends StatefulWidget {
  final ProductData productData;
  final OnDelete? onDelete;
  final state = _ProductFormState();
  final bool isEdit;
  ProductForm({
    Key? key,
    required this.productData,
    this.onDelete,
    this.isEdit = false,
  }) : super(key: key);

  @override
  State<ProductForm> createState() => state;

  bool isValid() => state.validate();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  File? imageFile;
  late bool _isExpand;

  @override
  void initState() {
    super.initState();
    _isExpand = !widget.isEdit;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(AppSizes.padding),
        child: Card(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.padding),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Product",
                        style: titleText,
                      ),
                      if (!widget.isEdit)
                        IconButton(
                          icon: const Icon(
                            Icons.minimize_outlined,
                            color: Colors.red,
                          ),
                          onPressed: widget.onDelete,
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (widget.isEdit) ...[
                    TextFormField(
                      initialValue: widget.productData.income.toString(),
                      keyboardType: TextInputType.number,
                      onSaved: (val) =>
                          widget.productData.income = int.parse(val!),
                    ),
                    TextFormField(
                      initialValue: widget.productData.out.toString(),
                      keyboardType: TextInputType.number,
                      onSaved: (val) =>
                          widget.productData.out = int.parse(val!),
                    )
                  ],
                  if (_isExpand) ...[
                    TextFormField(
                      initialValue: widget.productData.title,
                      onSaved: (val) => widget.productData.title = val,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Field Cannot be empty';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                          labelText: "Title", hintText: "Product Title"),
                    ),
                    const SizedBox(height: 15),
                    if (imageFile != null ||
                        widget.productData.imagePath != null)
                      SizedBox(
                          height: 200,
                          width: 500,
                          child: imageFile != null
                              ? Image.file(imageFile!)
                              : Image.network(widget.productData.imagePath!)),
                    GestureDetector(
                      child: const Text("Choose Image"),
                      onTap: () => _showImagePickerOptions(context),
                    ),
                  ],
                  const SizedBox(height: 10),
                  if(widget.isEdit)
                  _buildToggle(context),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildToggle(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      child: Text(_isExpand ? 'Hide' : 'Show'),
    );
  }

  void _toggle(){
    _isExpand = !_isExpand;
    setState((){});
  }
  _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (BuildContext context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: const Text("Choose Image From Gallery"),
                    onTap: () => getImage(source: ImageSource.gallery),
                  ),
                  ListTile(
                    title: const Text("Choose Image From Camera"),
                    onTap: () => getImage(source: ImageSource.camera),
                  ),
                ],
              );
            },
          );
        });
  }

  void getImage({required ImageSource source}) async {
    final _file = await ImagePicker().pickImage(source: source);

    if (_file?.path != null) {
      setState(() {
        imageFile = File(_file!.path);
        widget.productData.image = imageFile;
      });
    }
  }

  bool validate() {
    final valid = _formKey.currentState!.validate();
    if (valid) _formKey.currentState!.save();
    return valid;
  }
}
