import 'dart:convert';

import 'package:delivery_food_app_from_behance1/api/order_api/order_api.dart';
import 'package:delivery_food_app_from_behance1/models/order.dart';
import 'package:delivery_food_app_from_behance1/pages/order_detail_product.dart';
import 'package:delivery_food_app_from_behance1/widgets/menu_widget.dart';
import 'package:delivery_food_app_from_behance1/widgets/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../api/api_connections.dart';
import '../utils/dimension.dart';
import 'package:http/http.dart' as http;

import '../utils/shared_prefer.dart';

class AllOrders extends StatefulWidget {
  AllOrders({Key? key}) : super(key: key);

  @override
  State<AllOrders> createState() => _AllOrdersState();
}

var _scaffoldState = GlobalKey<ScaffoldState>();

class _AllOrdersState extends State<AllOrders> {
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<OrderApi>(context, listen: false).getAllOrders();

    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        Provider.of<OrderApi>(context, listen: false).getAllOrders();
      }
    });
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var orderListProvider = Provider.of<OrderApi>(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: RefreshIndicator(
        onRefresh: () async {
          orderListProvider.clearOrderList();
          orderListProvider.getAllOrders();
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          drawer: SideBar(),
          key: _scaffoldState,
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
                onPressed: () {
                  _scaffoldState.currentState?.openDrawer();
                },
                icon: const MenuWidget()),
            elevation: 0,
            title: const Text("Все заказы"),
            actions: [
              IconButton(
                  onPressed: () {
                    orderListProvider.clearOrderList();
                    orderListProvider.getAllOrders();
                  },
                  icon: Icon(
                    Icons.sync,
                    size: Dimensions.size25,
                  ))
            ],
          ),
          body: Column(
            children: [
              if (orderListProvider.orderList.isEmpty)
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                )
              else
                Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                        shrinkWrap: true,
                        controller: _scrollController,
                        itemCount: orderListProvider.orderList.length + 1,
                        itemBuilder: (context, index) {
                          if (index < orderListProvider.orderList.length) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (cotnext) =>
                                            OrderDetailProduct(
                                                orderId: orderListProvider
                                                    .orderList[index].id!)));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: Dimensions.size5,
                                    right: Dimensions.size5,
                                    bottom: Dimensions.size5 * 2),
                                child: Container(
                                  height: Dimensions.size5 * 17,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 120,
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                opacity: 0.5,
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    "assets/images/order_image.jpg"))),
                                      ),
                                      SizedBox(
                                        width: Dimensions.size5,
                                      ),
                                      Expanded(
                                        child: Card(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Итог: ${orderListProvider.orderList[index].total}c",
                                                    style: TextStyle(
                                                        fontSize:
                                                            Dimensions.size16),
                                                  ),
                                                  Expanded(child: Container()),
                                                  Expanded(
                                                    child: Text(
                                                      "${orderListProvider.orderList[index].address}",
                                                      style: TextStyle(
                                                          fontSize: Dimensions
                                                                  .size14 -
                                                              2),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Количество: ${orderListProvider.orderList[index].qtyOfProducts}",
                                                    style: TextStyle(
                                                        fontSize:
                                                            Dimensions.size16),
                                                  ),
                                                  Text(
                                                    DateFormat.yMMMMd('RU')
                                                        .format(DateTime.parse(
                                                            orderListProvider
                                                                .orderList[
                                                                    index]
                                                                .dateTime!
                                                                .substring(
                                                                    0, 10))),
                                                    style: TextStyle(
                                                        fontSize:
                                                            Dimensions.size14 -
                                                                2),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return orderListProvider.hasMore == true
                                ? const Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.white),
                                  )
                                : Container();
                          }
                        }),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
