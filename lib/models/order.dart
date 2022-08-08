import 'package:delivery_food_app_from_behance1/models/product.dart';

class Order {
  int? id;
  int? userId;
  int? qtyOfProducts;
  double? total;
  List<Product>? productList;
  String? dateTime;

  Order(
      {this.id,
      this.userId,
      this.qtyOfProducts,
      this.total,
      this.productList,
      this.dateTime});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        id: json['id'],
        userId: json['userId'],
        qtyOfProducts: json['qtyOfProducts'],
        total: json['total'],
        dateTime: json['created_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "qty_of_products": qtyOfProducts,
      "total": total,
      "productList": productList
    };
  }
}
