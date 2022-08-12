import 'dart:convert';

import 'package:delivery_food_app_from_behance1/api/api_connections.dart';
import 'package:delivery_food_app_from_behance1/api/user_api/user_api.dart';
import 'package:delivery_food_app_from_behance1/models/user.dart';
import 'package:delivery_food_app_from_behance1/pages/menu_page.dart';
import 'package:delivery_food_app_from_behance1/state_menagement_provider/side_bar_page.dart';
import 'package:delivery_food_app_from_behance1/utils/dimension.dart';
import 'package:delivery_food_app_from_behance1/widgets/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../utils/shared_prefer.dart';
import '../widgets/menu_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _nameController = TextEditingController(text: '');
  TextEditingController _emailController = TextEditingController(text: '');
  TextEditingController _passwordController = TextEditingController(text: '');
  TextEditingController _mobileNumberController =
      TextEditingController(text: '');
  Future<void> getUser({String password = ''}) async {
    try {
      EasyLoading.show(
          status: "",
          indicator: CircularProgressIndicator(
            color: Colors.white,
          ));
      var res = await http.get(
        Uri.parse(
            "${ApiConnections.URL}/get/user/${await SharedPrefer().getUserID()}"),
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
          if (password.isNotEmpty) {
            await SharedPrefer().setUserPassword(password);
          }
          _emailController.text = map['user']['email'];
          _nameController.text = map['user']['name'];
          _mobileNumberController.text = map['user']['phone_number'];
          await SharedPrefer().setUserEmail(map['user']['email']);
          await SharedPrefer().setUserName(map['user']['name']);
          _passwordController.text = await SharedPrefer().getUserPassword();
          EasyLoading.dismiss();
          setState(() {});
        }
      }
    } catch (e) {
      print(e);
    }
  }

  var _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        drawer: SideBar(),
        key: _scaffoldState,
        backgroundColor: Colors.black,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  getUser();
                },
                icon: Icon(
                  Icons.sync,
                  size: Dimensions.size25,
                ))
          ],
          elevation: 0,
          backgroundColor: Colors.black,
          title: const Text("Профиль"),
          leading: IconButton(
              onPressed: () {
                _scaffoldState.currentState?.openDrawer();
                Future.delayed(Duration(microseconds: 10), () {
                  FocusManager.instance.primaryFocus?.unfocus();
                });
              },
              icon: const MenuWidget()),
        ),
        body: SizedBox(
            width: double.maxFinite,
            child: Padding(
              padding: EdgeInsets.only(
                  left: Dimensions.size30, right: Dimensions.size30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: Dimensions.size20,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(
                            Dimensions.size10,
                            Dimensions.size20 / 10,
                            Dimensions.size10,
                            Dimensions.size20 / 10),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.size5),
                            border: Border.all(color: Colors.white)),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "Name",
                              labelStyle:
                                  TextStyle(fontSize: Dimensions.size14)),
                          controller: _nameController,
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.size20,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(
                            Dimensions.size10,
                            Dimensions.size20 / 10,
                            Dimensions.size10,
                            Dimensions.size20 / 10),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.size5),
                            border: Border.all(color: Colors.white)),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "Email",
                              labelStyle:
                                  TextStyle(fontSize: Dimensions.size14)),
                          controller: _emailController,
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.size20,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(
                            Dimensions.size10,
                            Dimensions.size20 / 10,
                            Dimensions.size10,
                            Dimensions.size20 / 10),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.size5),
                            border: Border.all(color: Colors.white)),
                        child: Stack(
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Password",
                                  labelStyle:
                                      TextStyle(fontSize: Dimensions.size14)),
                              controller: _passwordController,
                            ),
                            // Positioned(
                            //     bottom: 0,
                            //     right: 0,
                            //     child: IconButton(
                            //         onPressed: () {

                            //         },
                            //         icon: Icon(
                            //           Icons.remove_red_eye_outlined,
                            //           color: _obText == false
                            //               ? HexColor('e3b100')
                            //               : Colors.white,
                            //         )))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.size20,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(
                            Dimensions.size10,
                            Dimensions.size20 / 10,
                            Dimensions.size10,
                            Dimensions.size20 / 10),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.size5),
                            border: Border.all(color: Colors.white)),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "Mobile Number",
                              labelStyle:
                                  TextStyle(fontSize: Dimensions.size14)),
                          controller: _mobileNumberController,
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: Container()),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(HexColor("2db45b"))),
                      onPressed: () async {
                        Map<String, dynamic> body = {
                          "name": _nameController.text.trim(),
                          "email": _emailController.text.trim(),
                          "password": _passwordController.text.trim(),
                          "phone_number": _mobileNumberController.text.trim()
                        };
                        AlertDialog newAlertDialog = AlertDialog(
                          title: Text("Проверка данных",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.size15)),
                          content: Text("Вы точно хотите изменить данные?",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.size15)),
                          actions: [
                            TextButton(
                                onPressed: () async {
                                  EasyLoading.show(status: "Выполняется");
                                  await UserApi()
                                      .updateUser(
                                          body, _passwordController.text.trim())
                                      .then((value) {
                                    if (value == false) {
                                      EasyLoading.dismiss();
                                      Navigator.pop(context);
                                      Get.snackbar("Ошибка", "Ошибка сервера");
                                    } else {
                                      Navigator.pop(context);
                                      EasyLoading.showSuccess("Все!");
                                      getUser(
                                          password:
                                              _passwordController.text.trim());
                                      Future.delayed(
                                          Duration(microseconds: 100), () {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      });
                                    }
                                  });
                                },
                                child: Text("Да",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Dimensions.size14))),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Нет",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Dimensions.size14)))
                          ],
                        );
                        showDialog(
                            context: context,
                            builder: (cotnext) => newAlertDialog);
                      },
                      child: Text(
                        "Сохранить изменения",
                        style: TextStyle(fontSize: Dimensions.size14),
                      ))
                ],
              ),
            )),
      ),
    );
  }
}
