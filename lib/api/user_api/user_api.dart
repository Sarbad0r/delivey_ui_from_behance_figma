import 'dart:convert';

import 'package:delivery_food_app_from_behance1/api/user_api/user_abs.dart';
import 'package:delivery_food_app_from_behance1/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../utils/shared_prefer.dart';
import '../api_connections.dart';

class UserApi extends ChangeNotifier implements UserAbs {
  List<User> userList = [];
  bool getCurrentUser = false;
  int page = 1;
  bool hasMore = true;
  void clearUserList() {
    userList.clear();
    getCurrentUser = false;
    page = 1;
    hasMore = true;
    notifyListeners();
  }

  @override
  Future<bool> updateUser(Map<String, dynamic> body, String password) async {
    bool success = false;
    try {
      var res = await http.put(
        Uri.parse(
            "${ApiConnections.URL}/update/user/${await SharedPrefer().getUserID()}"),
        body: jsonEncode(body),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${await SharedPrefer().getToken()}',
        },
      );
      if (res.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(res.body);
        if (map['success'] == true) {
          success = true;
        }
      }
    } catch (e) {
      print(e);
    }
    return success;
  }

  @override
  Future<bool> logout() async {
    bool success = false;
    try {
      var res = await http.post(
        Uri.parse("${ApiConnections.URL}/logout"),
        body: jsonEncode({"token": "${await SharedPrefer().getToken()}"}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${await SharedPrefer().getToken()}',
        },
      );
      print(res.body);
      if (res.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(res.body);
        if (map['success'] == true) {
          success = true;
        }
      }
    } catch (e) {
      print(e);
    }
    return success;
  }

  @override
  Future<void> getAllUsers() async {
    if (hasMore == false) return;
    const int maxLength = 15;
    try {
      var res = await http.get(Uri.parse(
          "${ApiConnections.URL}/get/alluser/companyroom/${await SharedPrefer().getUserID()}/$maxLength?page=$page"));
      if (res.statusCode == 200) {
        print(res.body);
        Map<String, dynamic> map = jsonDecode(res.body);
        if (map['success'] == true) {
          if (getCurrentUser == false) {
            userList.add(User.fromJson(map['user']));
            getCurrentUser = true;
          }
          List<dynamic> list = map['users']['data'];
          for (int i = 0; i < list.length; i++) {
            userList.add(User.fromJson(list[i]));
          }
          if (list.length < maxLength) {
            hasMore = false;
          }
          page++;
          notifyListeners();
        } else {
          Get.snackbar("Ошибка", "Ошибка подключения");
          hasMore = false;
          notifyListeners();
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
