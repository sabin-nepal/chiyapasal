class Product {
  final String? id;
  final String title;
  final String imagePath;
  final int income;
  final int out;
  final DateTime createdAt;

  Product({
    this.id,
    required this.title,
    required this.imagePath,
    required this.income,
    required this.out,
    required this.createdAt,
  });

  Product.fromJson(String id, Map<String, dynamic> data)
      : this(
          id: id,
          title: data['title'],
          imagePath: data['imagePath'],
          income: data['income'],
          out: data['out'],
          createdAt: data['createdAt'].toDate(),
        );

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'imagePath': imagePath,
      'income': income,
      'out': out,
      'createdAt': createdAt,
    };
  }
}
