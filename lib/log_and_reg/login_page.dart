import 'dart:convert';
import 'dart:ui';

import 'package:delivery_food_app_from_behance1/api/api_connections.dart';
import 'package:delivery_food_app_from_behance1/log_and_reg/register_page.dart';
import 'package:delivery_food_app_from_behance1/models/user.dart';
import 'package:delivery_food_app_from_behance1/pages/category_page.dart';
import 'package:delivery_food_app_from_behance1/pages/menu_page.dart';
import 'package:delivery_food_app_from_behance1/utils/dimension.dart';
import 'package:delivery_food_app_from_behance1/utils/shared_prefer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController(text: '');
  TextEditingController _passwordController = TextEditingController(text: '');

  Future<bool> checkInternetConn() async {
    bool checkInternet = false;
    checkInternet = await InternetConnectionChecker().hasConnection;
    return checkInternet;
  }

  Future<void> login(Map<String, dynamic> json) async {
    var res = await http.post(
      Uri.parse("${ApiConnections.URL}/login/user"),
      body: jsonEncode(json),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);
      if (json['success'] == false) {
        Get.snackbar("Ошибка", "${json['message']}");
        return;
      } else {
        await SharedPrefer().setToken(json['token']);
        await SharedPrefer().setUserId(json['user']['id']);
        await SharedPrefer().setUserEmail(json['user']['email']);
        await SharedPrefer().setUserName(json['user']['name']);
        print(json['token']);
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const CategoryPage()),
            (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.darken),
                  fit: BoxFit.cover,
                  image: const AssetImage("assets/images/background.jpg"))),
          width: double.maxFinite,
          child: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 4.0),
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.0)),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "FoodMap",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Dimensions.size40),
                  ),
                  SizedBox(
                    height: Dimensions.size20,
                  ),
                  const Text("Hey! We missed you"),
                  SizedBox(
                    height: Dimensions.size30,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: Dimensions.size30, right: Dimensions.size30),
                    height: Dimensions.size50,
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          hintText: "E-mail",
                          hintStyle: const TextStyle(color: Colors.white),
                          contentPadding: EdgeInsets.only(
                            top: 4,
                            left: Dimensions.size15,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            size: Dimensions.size25,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0),
                              borderRadius:
                                  BorderRadius.circular(Dimensions.size30)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0),
                              borderRadius:
                                  BorderRadius.circular(Dimensions.size30))),
                      onChanged: (v) {},
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.size15,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: Dimensions.size30, right: Dimensions.size30),
                    height: Dimensions.size50,
                    child: TextField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(
                              color: Colors.white, fontSize: Dimensions.size20),
                          contentPadding: EdgeInsets.only(
                            top: 4,
                            left: Dimensions.size15,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            size: Dimensions.size25,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0),
                              borderRadius:
                                  BorderRadius.circular(Dimensions.size30)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0),
                              borderRadius:
                                  BorderRadius.circular(Dimensions.size30))),
                      onChanged: (v) {},
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.size15,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_emailController.text.isEmpty ||
                          _passwordController.text.isEmpty) {
                        Get.snackbar("Ошибка", "Поля не могут быть пустыми");
                        return;
                      } else if (!_emailController.text.isEmail) {
                        Get.snackbar("Ошибка", "Введите Email");
                        return;
                      } else if (await checkInternetConn() == false) {
                        Get.snackbar("Ошибка", "Проверьте интернет соединение");
                        return;
                      } else {
                        Map<String, dynamic> user = {
                          "email": _emailController.text,
                          "password": _passwordController.text
                        };
                        login(user);
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          left: Dimensions.size30, right: Dimensions.size30),
                      decoration: BoxDecoration(
                          color: HexColor("2db45b"),
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.size30))),
                      height: Dimensions.size50,
                      child: Center(
                        child: Text(
                          "Log in",
                          style: TextStyle(
                              fontSize: Dimensions.size20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.size15,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "or sign in with",
                      style: TextStyle(fontSize: Dimensions.size20),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.size20,
                  ),
                  Container(
                    width: Dimensions.width200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.twitter,
                            size: Dimensions.size25,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.facebookF,
                            size: Dimensions.size25,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.googlePlusG,
                            size: Dimensions.size25,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.size20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(fontSize: Dimensions.size16),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()),
                              (route) => false);
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            fontSize: Dimensions.size16,
                            color: HexColor("2db45b"),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
