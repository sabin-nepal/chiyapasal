class User {
  final String id;
  final bool isEditor;
  final String email;
  User({required this.id, required this.isEditor, required this.email});
  factory User.fromJson(String id, Map<String, dynamic>? data) {
    return User(
      id: id,
      isEditor: data!['isEditor'] ?? false,
      email: data['email']
    );
  }
}
