class User {
  final int id;
  final String role;
  final String name;

  User({this.id, this.role, this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      role: json['role'],
      name: json['name'],
    );
  }
}
