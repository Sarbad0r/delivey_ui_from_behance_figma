import 'package:delivery_food_app_from_behance1/pages/all_orders.dart';
import 'package:delivery_food_app_from_behance1/pages/category_page.dart';
import 'package:flutter/material.dart';

import '../api/api_connections.dart';
import '../utils/dimension.dart';
import '../utils/shared_prefer.dart';

class SideBar extends StatefulWidget {
  SideBar({Key? key}) : super(key: key);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Colors.black),
            accountName: Row(
              children: [
                FutureBuilder<int>(
                    future: SharedPrefer().getUserID(),
                    builder: (context, snap) {
                      bool checkConnection =
                          snap.connectionState == ConnectionState.done;
                      if (!checkConnection) {
                        return const CircularProgressIndicator();
                      } else if (snap.hasError) {
                        return Text("${snap.error}");
                      } else if (snap.data == null) {
                        return Text("Empty");
                      } else {
                        return Container(
                          width: Dimensions.size50,
                          height: Dimensions.size50,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.size30),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "${ApiConnections.urlImage}/${snap.data}"))),
                        );
                      }
                    }),
                SizedBox(
                  width: Dimensions.size10,
                ),
                FutureBuilder<String>(
                    future: SharedPrefer().getUserName(),
                    builder: (context, snap) {
                      bool checkConnection =
                          snap.connectionState == ConnectionState.done;
                      if (!checkConnection) {
                        return CircularProgressIndicator();
                      }
                      if (snap.data!.isEmpty) {
                        return Text("");
                      }
                      if (snap.hasError) {
                        return Text("${snap.error}");
                      } else {
                        return Text(
                          "${snap.data} ",
                          style: const TextStyle(color: Colors.white),
                        );
                      }
                    }),
              ],
            ),
            accountEmail: FutureBuilder<String>(
                future: SharedPrefer().getUserEmail(),
                builder: (context, snap) {
                  bool checkConnection =
                      snap.connectionState == ConnectionState.done;
                  if (!checkConnection) {
                    return CircularProgressIndicator();
                  }
                  if (snap.data!.isEmpty) {
                    return Text("");
                  }
                  if (snap.hasError) {
                    return Text("${snap.error}");
                  } else {
                    return Text(
                      "${snap.data} ",
                      style: const TextStyle(color: Colors.white),
                    );
                  }
                }),
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => CategoryPage()),
                        (route) => false);
                  },
                  child: Text(
                    "Главная",
                    style: TextStyle(
                        color: Colors.white, fontSize: Dimensions.size14),
                  ))),
          Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => AllOrders()),
                        (route) => false);
                  },
                  child: Text(
                    "Все заказы",
                    style: TextStyle(
                        color: Colors.white, fontSize: Dimensions.size14),
                  ))),
        ],
      ),
    );
  }
}
