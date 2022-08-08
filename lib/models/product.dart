class Product {
  int? id;
  String? name;
  String? image;
  double? price;
  int? quantity;
  String? about;
  String? ingredients;
  bool? favorite;

  Product(
      {this.id,
      this.name,
      this.image,
      this.price,
      this.quantity,
      this.about,
      this.ingredients,
      this.favorite});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        quantity: json['quantity'],
        about: json['about'],
        ingredients: json['ingredients']);
  }

  double total() {
    return quantity! * price!;
  }
}
