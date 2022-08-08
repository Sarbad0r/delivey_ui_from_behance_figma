class User {
  int? id;
  String? name;
  String? image;
  String? email;
  String? password;

  User(
      {this.id,
      this.name,
      required this.email,
      this.image,
      required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        image: json['image'],
        name: json['name'],
        email: json['email'],
        password: json['password']);
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "image": image, "email": email, "password": password};
  }
}
