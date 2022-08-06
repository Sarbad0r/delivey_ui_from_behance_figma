class User {
  int? id;
  String? name;
  String? email;
  String? password;

  User({this.id, this.name, required this.email, required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        password: json['password']);
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "email": email, "password": password};
  }
}
