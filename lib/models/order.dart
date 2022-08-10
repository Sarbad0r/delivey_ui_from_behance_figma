import 'dart:convert';

import 'package:delivery_food_app_from_behance1/models/product.dart';

class Order {
  int? id;
  int? userId;
  int? qtyOfProducts;
  double? total;
  List<Product>? productList;
  String? dateTime;
  String? address;

  Order(
      {this.id,
      this.userId,
      this.qtyOfProducts,
      this.total,
      this.productList,
      this.dateTime,
      this.address});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        id: json['id'],
        userId: json['user_id'],
        qtyOfProducts: json['qty_of_products'],
        total: json['total'].toDouble(),
        dateTime: json['created_at'],
        address: json['address']);
  }

  Map<String, dynamic> toJson() {
    var map = [];
    for (var all in productList!) {
      map.add(all.toJson());
    }
    return {
      "user_id": userId,
      "qty_of_products": qtyOfProducts,
      "total": total,
      "productList": map,
      "address": address
    };
  }
}
