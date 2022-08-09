import 'dart:convert';

import 'package:delivery_food_app_from_behance1/api/api_connections.dart';
import 'package:delivery_food_app_from_behance1/api/product_api/product_abs.dart';
import 'package:delivery_food_app_from_behance1/models/product.dart';
import 'package:http/http.dart' as http;

import '../../utils/shared_prefer.dart';

class ProductApi implements ProductAbs {
  @override
  Future<List<Product>> getProductList(int orderId) async {
    List<Product> productList = [];
    try {
      var res = await http.get(
        Uri.parse("${ApiConnections.URL}/get/productById/$orderId"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${await SharedPrefer().getToken()}',
        },
      );
      print(res.body);
      if (res.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(res.body);
        List<dynamic> list = map['products'];
        for (int i = 0; i < list.length; i++) {
          productList.add(Product.fromJson(list[i]));
        }
      }
    } catch (e) {
      print(e);
    }
    return productList;
  }
}
