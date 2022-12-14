import 'dart:convert';

import 'package:delivery_food_app_from_behance1/api/api_connections.dart';
import 'package:delivery_food_app_from_behance1/api/order_api/order_abs.dart';
import 'package:delivery_food_app_from_behance1/models/order.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../utils/shared_prefer.dart';

class OrderApi extends ChangeNotifier implements AbsOrder {
  bool hasMore = true;
  int page = 1;
  final List<Order> _orderList = [];
  List<Order> get orderList => _orderList;
  void clearOrderList() {
    page = 1;
    hasMore = true;
    _orderList.clear();
    notifyListeners();
  }

  @override
  Future<void> deleteOrder() {
    // TODO: implement deleteOrder
    throw UnimplementedError();
  }

  @override
  Future<void> getAllOrders() async {
    if (hasMore == false) return;
    const limit = 20;
    try {
      var res = await http.get(
        Uri.parse(
            "${ApiConnections.URL}/get/orders/${await SharedPrefer().getUserID()}/$limit?page=$page"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${await SharedPrefer().getToken()}',
        },
      );
      print(res.body);
      if (res.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(res.body);
        List<dynamic> list = map['orders']['data'];
        if (list.isNotEmpty) {
          for (int i = 0; i < list.length; i++) {
            _orderList.add(Order.fromJson(list[i]));
          }
          page++;
          hasMore = true;
          if (list.length < limit) {
            hasMore = false;
          }
          notifyListeners();
        } else {
          hasMore = false;
          notifyListeners();
        }
      }
    } catch (e) {
      print(e);
    }
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
