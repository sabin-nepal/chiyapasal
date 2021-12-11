class Auction {
  String? id;
  final String title;
  final DateTime createdAt;
  final String updatedBy;

  Auction(
      {
      this.id,
      required this.title,
      required this.createdAt,
      required this.updatedBy});

  Auction.fromJson(String id, Map<String, dynamic> data)
      : this(
          id: id,
          title: data['title'],
          createdAt: data['createdAt'].toDate(),
          updatedBy: data['updatedBy'],
        );
  Map<String, dynamic> toJson() {
    return {'title': title, 'createdAt': createdAt, 'updatedBy': updatedBy};
  }
}
