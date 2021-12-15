class Product {
  final String? id;
  final String title;
  final String imagePath;
  final String income;
  final String outgo;
  final DateTime createdAt;

  Product({
    this.id,
    required this.title,
    required this.imagePath,
    required this.income,
    required this.outgo,
    required this.createdAt,
  });

  Product.fromJson(String id, Map<String, dynamic> data)
      : this(
          id: id,
          title: data['title'],
          imagePath: data['imagePath'],
          income: data['income'],
          outgo: data['outgo'],
          createdAt: data['createdAt'],
        );

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'imagePath': imagePath,
      'income': income,
      'outgo': outgo,
      'createdAt': createdAt,
    };
  }
}
