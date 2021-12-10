class User {
  final String id;
  final bool isEditor;
  User({required this.id, required this.isEditor});
  factory User.fromJson(String id, Map<String, dynamic>? data) {
    return User(
      id: id,
      isEditor: data!['isEditor'] ?? false,
    );
  }
}
