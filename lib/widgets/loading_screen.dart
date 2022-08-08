// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:ui';

import 'package:delivery_food_app_from_behance1/api/api_connections.dart';
import 'package:delivery_food_app_from_behance1/log_and_reg/login_page.dart';
import 'package:delivery_food_app_from_behance1/pages/category_page.dart';
import 'package:delivery_food_app_from_behance1/pages/menu_page.dart';
import 'package:delivery_food_app_from_behance1/utils/dimension.dart';
import 'package:delivery_food_app_from_behance1/utils/shared_prefer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool hasInterner = true;
  Future<void> checkToken() async {
    try {
      var res = await http.post(
        Uri.parse("${ApiConnections.URL}/check/token"),
        body: jsonEncode({"token": "${await SharedPrefer().getToken()}"}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
      );
      print(await SharedPrefer().getToken());
      print(await SharedPrefer().getUserID());
      print(jsonDecode(res.body));
      if (res.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(res.body);
        print(map);
        if (map['success'] == false) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => false);
          return;
        }
        if (map['success'] == true) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (cotnext) => const CategoryPage()),
              (route) => false);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    InternetConnectionChecker().onStatusChange.listen((event) {
      bool check = event == InternetConnectionStatus.connected;
      if (mounted) {
        setState(() {
          hasInterner = check;
        });
        if (hasInterner == true) {
          checkToken();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5), BlendMode.darken),
                    fit: BoxFit.cover,
                    image: const AssetImage("assets/images/background.jpg"))),
            width: double.maxFinite,
            child: Stack(children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 4.0),
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.0)),
                ),
              ),
              Container(
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: Dimensions.size20,
                    ),
                    if (hasInterner == false)
                      Text(
                        "Проверьте интернет соединение",
                        style: TextStyle(fontSize: Dimensions.size14),
                      )
                  ],
                ),
              )
            ])));
  }
}
