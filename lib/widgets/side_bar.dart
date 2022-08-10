import 'package:delivery_food_app_from_behance1/pages/all_orders.dart';
import 'package:delivery_food_app_from_behance1/pages/category_page.dart';
import 'package:delivery_food_app_from_behance1/pages/profile_page.dart';
import 'package:delivery_food_app_from_behance1/state_menagement_provider/side_bar_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    var pageNumber = Provider.of<SideBarPage>(context);
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
                      if (snap.hasError) {
                        return Text("${snap.error}");
                      } else if (snap.data == null) {
                        return Container(
                          width: Dimensions.size50,
                          height: Dimensions.size50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(Dimensions.size30),
                          ),
                        );
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
                        return const CircularProgressIndicator();
                      }
                      if (snap.data!.isEmpty) {
                        return const Text("");
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
                    return const CircularProgressIndicator();
                  }
                  if (snap.data!.isEmpty) {
                    return const Text("");
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
                    if (pageNumber.numberOfPage == 1) {
                      return;
                    }
                    pageNumber.setPageNumber(1);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CategoryPage()),
                        (route) => false);
                  },
                  child: const Text(
                    "Главная",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ))),
          Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                  onPressed: () {
                    if (pageNumber.numberOfPage == 2) {
                      return;
                    }
                    pageNumber.setPageNumber(2);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => AllOrders()),
                        (route) => false);
                  },
                  child: const Text(
                    "Все заказы",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ))),
          Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                  onPressed: () {
                    if (pageNumber.numberOfPage == 3) {
                      return;
                    }
                    pageNumber.setPageNumber(3);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                        (route) => false);
                  },
                  child: const Text(
                    "Профиль",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ))),
        ],
      ),
    );
  }
}
