import 'dart:convert';
import 'dart:io';

import 'dart:ui';

import 'package:delivery_food_app_from_behance1/api/api_connections.dart';
import 'package:delivery_food_app_from_behance1/log_and_reg/login_page.dart';
import 'package:delivery_food_app_from_behance1/models/user.dart';
import 'package:delivery_food_app_from_behance1/pages/category_page.dart';
import 'package:delivery_food_app_from_behance1/utils/shared_prefer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../utils/dimension.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _emailController = TextEditingController(text: '');
  TextEditingController _nameController = TextEditingController(text: '');
  TextEditingController _passwordFirstController =
      TextEditingController(text: '');
  TextEditingController _passwordSecondController =
      TextEditingController(text: '');

  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    try {
      final image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _image = File(image.path);
        });
      }
    } catch (e) {
      Get.snackbar("Ошибка", "$e");
    }
  }

  Future<void> registration(Map<String, String> body, String filePath) async {
    try {
      Map<String, String> header = {
        'Content-Type': 'multipart/form-data',
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      };
      // 'Content-Type': 'application/json; charset=UTF-8',
      //   'Accept': 'application/json',
      var req = http.MultipartRequest(
          'POST', Uri.parse('${ApiConnections.URL}/create/user'))
        ..headers.addAll(header)
        ..files.add(await http.MultipartFile.fromPath('imagejun', filePath))
        ..fields.addAll(body);

      var res = await req.send();
      if (res.statusCode == 200) {
        final respStr = await res.stream.bytesToString();
        Map<String, dynamic> map = jsonDecode(respStr);
        print("map : ${map}");
        if (map['success'] == false) {
          Get.snackbar("Ошибка", "${map['message']}");
          return;
        }
        if (map['success'] == true) {
          await SharedPrefer().setUserName(map['user']['name']);
          await SharedPrefer().setUserEmail(map['user']['email']);
          await SharedPrefer().setUserId(map['user']['id']);
          await SharedPrefer().setToken(map['token']);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => CategoryPage()),
              (route) => false);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: ListView(
          shrinkWrap: true,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5), BlendMode.darken),
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/background.jpg"))),
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
                      Text("Hey! We missed you"),
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
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.size20),
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
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.size30))),
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
                          controller: _nameController,
                          decoration: InputDecoration(
                              hintText: "Name",
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.size20),
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
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.size30))),
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
                          controller: _passwordFirstController,
                          decoration: InputDecoration(
                              errorMaxLines: 15,
                              hintText: "Password",
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.size20),
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
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.size30))),
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
                          controller: _passwordSecondController,
                          decoration: InputDecoration(
                              errorMaxLines: 15,
                              hintText: "Repeat your password",
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.size20),
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
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.size30))),
                          onChanged: (v) {},
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.size25,
                      ),
                      if (_image == null)
                        TextButton(
                            onPressed: () {
                              pickImage();
                            },
                            child: Text(
                              "Выбрать фото",
                              style: TextStyle(color: Colors.white),
                            )),
                      if (_image != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: Dimensions.size50,
                              height: Dimensions.size50,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: FileImage(_image!)),
                                  borderRadius:
                                      BorderRadius.circular(Dimensions.size30)),
                            ),
                            SizedBox(
                              width: Dimensions.size15,
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _image = null;
                                  });
                                },
                                icon: Icon(
                                  FontAwesomeIcons.trash,
                                  size: Dimensions.size15,
                                ))
                          ],
                        ),
                      SizedBox(
                        height: Dimensions.size15,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (_emailController.text.isEmpty ||
                              _passwordFirstController.text.isEmpty ||
                              _passwordSecondController.text.isEmpty) {
                            Get.snackbar("Ошибка", "Поля не могут быть пустыми",
                                duration: const Duration(seconds: 2),
                                isDismissible: true);
                            return;
                          } else if (_passwordFirstController.text !=
                              _passwordSecondController.text) {
                            Get.snackbar("Ошибка", "Пароли не совпадают",
                                duration: const Duration(seconds: 2),
                                isDismissible: true);
                            return;
                          } else if (_image == null) {
                            Get.snackbar("", "Выберите фото");
                          } else {
                            Map<String, String> body = {
                              "name": _nameController.text,
                              "email": _emailController.text,
                              "password": _passwordSecondController.text
                            };
                            await registration(body, _image!.path);
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: Dimensions.size30,
                              right: Dimensions.size30),
                          decoration: BoxDecoration(
                              color: HexColor("2db45b"),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Dimensions.size30))),
                          height: Dimensions.size50,
                          child: Center(
                            child: Text(
                              "Register",
                              style: TextStyle(
                                  fontSize: Dimensions.size20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   height: Dimensions.size15,
                      // ),
                      // Align(
                      //   alignment: Alignment.center,
                      //   child: Text(
                      //     "or sign in with",
                      //     style: TextStyle(fontSize: Dimensions.size20),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: Dimensions.size20,
                      // ),
                      // Container(
                      //   width: Dimensions.width200,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       IconButton(
                      //         onPressed: () {},
                      //         icon: FaIcon(
                      //           FontAwesomeIcons.twitter,
                      //           size: Dimensions.size25,
                      //         ),
                      //       ),
                      //       IconButton(
                      //         onPressed: () {},
                      //         icon: FaIcon(
                      //           FontAwesomeIcons.facebookF,
                      //           size: Dimensions.size25,
                      //         ),
                      //       ),
                      //       IconButton(
                      //         onPressed: () {},
                      //         icon: FaIcon(
                      //           FontAwesomeIcons.googlePlusG,
                      //           size: Dimensions.size25,
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      SizedBox(
                        height: Dimensions.size20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: TextStyle(fontSize: Dimensions.size16),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                  (route) => false);
                            },
                            child: Text(
                              "Sign in",
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
          ],
        ),
      ),
    );
  }
}
