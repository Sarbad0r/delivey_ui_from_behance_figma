class Category {
  int? id;
  double? rating;
  String? name;
  String? image;
  String? countryCuisine;
  double? discount;
  Category(
      {this.id,
      required this.rating,
      required this.image,
      required this.name,
      required this.countryCuisine,
      required this.discount});

  static List<Category> getListOfCategory() {
    return [
      Category(
          id: 1,
          rating: 4.5,
          name: "Murakami",
          countryCuisine: "Asian",
          discount: 35,
          image: 'assets/images/murakami_welcome.jpg'),
      Category(
          id: 2,
          rating: 4.7,
          name: "Caffeelat",
          countryCuisine: "Coffee Desert",
          discount: 20,
          image: 'assets/images/coffeelat.jpg'),
      Category(
          id: 3,
          rating: 4.8,
          name: "Burger King",
          countryCuisine: "Burger Europian",
          discount: 25,
          image: 'assets/images/burger_king.jpg'),
      Category(
          id: 4,
          rating: 4.8,
          name: "Salat",
          countryCuisine: "Salats Europian",
          discount: 25,
          image: 'assets/images/salat.jpg'),
    ];
  }
}
