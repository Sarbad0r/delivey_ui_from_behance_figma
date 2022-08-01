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

  double total() {
    return quantity! * price!;
  }
}
