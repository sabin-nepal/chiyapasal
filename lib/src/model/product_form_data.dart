import 'dart:io';

class ProductData {
  String? title;
  File? image;
  String? imagePath;
  int? income;
  int? out;
  ProductData(
      {this.title, this.image, this.imagePath, this.income = 0, this.out});
}
