import 'package:delivery_food_app_from_behance1/api/user_api/user_api.dart';
import 'package:delivery_food_app_from_behance1/utils/dimension.dart';
import 'package:delivery_food_app_from_behance1/utils/shared_prefer.dart';
import 'package:delivery_food_app_from_behance1/widgets/menu_widget.dart';
import 'package:delivery_food_app_from_behance1/widgets/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:provider/provider.dart';

import '../api/api_connections.dart';

class CompanyRoom extends StatefulWidget {
  const CompanyRoom({Key? key}) : super(key: key);

  @override
  State<CompanyRoom> createState() => _CompanyRoomState();
}

class _CompanyRoomState extends State<CompanyRoom> {
  var _scaffoldState = GlobalKey<ScaffoldState>();
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var userList = Provider.of<UserApi>(context, listen: false);
    userList.getAllUsers();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        userList.getAllUsers();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserApi>(context);
    return Scaffold(
      drawer: SideBar(),
      key: _scaffoldState,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                userProvider.clearUserList();
                userProvider.getAllUsers();
              },
              icon: Icon(
                Icons.sync,
                size: Dimensions.size25,
              ))
        ],
        leading: IconButton(
            onPressed: () {
              _scaffoldState.currentState?.openDrawer();
            },
            icon: const MenuWidget()),
        title: const Text("Company room"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: Dimensions.size15,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: Dimensions.size30, right: Dimensions.size30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        "Your order",
                        style: TextStyle(fontSize: Dimensions.size20),
                      ),
                      Icon(
                        Icons.location_on,
                        size: Dimensions.size25,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Total: ",
                        style: TextStyle(
                            color: HexColor('e3b100'),
                            fontSize: Dimensions.size20),
                      ),
                      Text(
                        "Delivering 40grn",
                        style: TextStyle(fontSize: Dimensions.size20),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: Dimensions.size20,
          ),
          if (userProvider.userList.isEmpty)
            const Expanded(
                child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ))
          else
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                    left: Dimensions.size30, right: Dimensions.size30),
                child: ListView.builder(
                    controller: _scrollController,
                    itemCount: userProvider.userList.length + 1,
                    itemBuilder: (context, index) {
                      if (index < userProvider.userList.length) {
                        return Column(
                          children: [
                            Container(
                              height: Dimensions.size100,
                              color: Colors.black,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: Dimensions.size70,
                                        height: Dimensions.size70,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.size50),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    "${ApiConnections.urlImageUsers}${getCutImage(userProvider.userList[index].image!)}"))),
                                      ),
                                      SizedBox(
                                        width: Dimensions.size10,
                                      ),
                                      Text(
                                          "${userProvider.userList[index].name}")
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "\$40",
                                        style: TextStyle(
                                            fontSize: Dimensions.size14),
                                      ),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.check,
                                            size: Dimensions.size25,
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        );
                      } else {
                        return userProvider.hasMore == true
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Container();
                      }
                    }),
              ),
            )
        ],
      ),
    );
  }

  String getCutImage(String image) {
    return image.substring(6, image.length);
  }
}
