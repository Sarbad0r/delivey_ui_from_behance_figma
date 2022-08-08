import 'package:flutter/cupertino.dart';

import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  List<Product> listOfProduct = [
    Product(
        id: 1,
        name: "Alaska",
        image: 'assets/images/alaska_seaFood.jpg',
        price: 24.50,
        quantity: 0,
        about:
            "Roll with fresh salmon, soft avocado and cream cheese under a wide layer of massago caviar for true gourmets",
        favorite: false),
    Product(
        id: 2,
        name: "Big food",
        image: 'assets/images/food_two.jpg',
        price: 15.50,
        quantity: 0,
        about:
            "Roll with fresh salmon, soft avocado and cream cheese under a wide layer of massago caviar for true gourmets",
        favorite: false),
    Product(
        id: 3,
        name: "Big food too",
        image: 'assets/images/food_two.jpg',
        price: 15.50,
        quantity: 0,
        about:
            "Roll with fresh salmon, soft avocado and cream cheese under a wide layer of massago caviar for true gourmets",
        favorite: false),
  ];

  List<Product> cartProductList = [];
  List<Product> favoritesProductList = [];

  void addToCart(Product product) {
    if (!cartProductList.contains(product)) {
      product.quantity = 1;
      cartProductList.add(product);
    } else {
      var getProduct =
          cartProductList.firstWhere((element) => element.id == product.id);
      getProduct.quantity = getProduct.quantity! + 1;
    }
    notifyListeners();
  }

  void removeFromCart(Product product) {
    if (!cartProductList.contains(product)) {
      return;
    }
    var getProduct =
        cartProductList.firstWhere((element) => element.id == product.id);
    if (getProduct.quantity! > 1) {
      getProduct.quantity = getProduct.quantity! - 1;
    } else {
      getProduct.quantity = 0;
      cartProductList.removeWhere((element) => element.id == getProduct.id);
    }

    notifyListeners();
  }

  bool checkProductCart(Product product) {
    return cartProductList.contains(product);
  }

  bool checkProductFavorite(Product product) {
    return favoritesProductList.contains(product);
  }

  void addToFavorite(Product product) {
    if (favoritesProductList.contains(product)) {
      favoritesProductList.removeWhere((element) => element.id == product.id);
    } else {
      favoritesProductList.add(product);
    }
    notifyListeners();
  }

  double totalOfCart() {
    double res = 0.0;
    for (var each in cartProductList) {
      res += each.total();
    }
    return res;
  }

  int totalQty() {
    int res = 0;
    for (int i = 0; i < cartProductList.length; i++) {
      res += cartProductList[i].quantity!;
    }
    return res;
  }

  void clearCart() {
    cartProductList.clear();
    notifyListeners();
  }
}
