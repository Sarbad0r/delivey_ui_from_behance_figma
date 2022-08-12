class User {
  int? id;
  String? name;
  String? image;
  String? email;
  String? password;
  String? phoneNumber;

  User(
      {this.id,
      this.name,
      required this.email,
      this.image,
      required this.password,
      this.phoneNumber});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        image: json['image'],
        name: json['name'],
        email: json['email'],
        password: json['password'],
        phoneNumber: json['']);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "image": image,
      "email": email,
      "password": password,
      "phone_number": phoneNumber
    };
  }
}
