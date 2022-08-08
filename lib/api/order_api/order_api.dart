import 'dart:convert';

import 'package:delivery_food_app_from_behance1/api/api_connections.dart';
import 'package:delivery_food_app_from_behance1/api/order_api/order_abs.dart';
import 'package:delivery_food_app_from_behance1/models/order.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../utils/shared_prefer.dart';

class OrderApi implements AbsOrder {
  @override
  Future<void> deleteOrder() {
    // TODO: implement deleteOrder
    throw UnimplementedError();
  }

  @override
  Future<List<Order>> getAllOrders() async {
    List<Order> orderList = [];
    try {
      var res = await http.get(
        Uri.parse(
            "${ApiConnections.URL}/get/orders/${await SharedPrefer().getUserID()}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${await SharedPrefer().getToken()}',
        },
      );
      if (res.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(res.body);
        List<dynamic> list = map['orders'];
        for (int i = 0; i < list.length; i++) {
          orderList.add(Order.fromJson(list[i]));
        }
      }
    } catch (e) {
      print(e);
    }
    return orderList;
  }

  @override
  Future<bool> setOrderAndProduct(Order order) async {
    bool checkSend = false;
    try {
      var res = await http.post(
        Uri.parse("${ApiConnections.URL}/set/orderandproduct"),
        body: jsonEncode(order.toJson()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${await SharedPrefer().getToken()}',
        },
      );
      print(jsonDecode(res.body));
      if (res.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(res.body);
        if (map['success'] == true) {
          checkSend = true;
        }
      }
    } catch (e) {
      print(e);
    }
    return checkSend;
  }
}
