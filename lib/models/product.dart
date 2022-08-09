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
        price: json['price'].toDouble(),
        quantity: json['quantity'],
        about: json['about'],
        image: json['image']
        // ingredients: json['ingredients']
        );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "image": image,
      "price": price,
      "quantity": quantity,
      "about": about,
      "ingredients": ingredients
    };
  }

  double total() {
    return quantity! * price!;
  }
}
