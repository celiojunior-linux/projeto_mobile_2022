class User {
  final int? id;
  final String username;
  final String password;

  User({required this.id, required this.username, required this.password});

  Map<String, dynamic> toJson() =>
      {'id': id, 'username': username, 'password': password};

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'], username: json['username'], password: json['password']);
  }

  @override
  String toString() {
    return '[$id] $username';
  }
}
