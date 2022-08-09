import 'package:delivery_food_app_from_behance1/api/order_api/order_api.dart';
import 'package:delivery_food_app_from_behance1/models/order.dart';
import 'package:delivery_food_app_from_behance1/pages/order_detail_product.dart';
import 'package:delivery_food_app_from_behance1/widgets/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/dimension.dart';

class AllOrders extends StatefulWidget {
  AllOrders({Key? key}) : super(key: key);

  @override
  State<AllOrders> createState() => _AllOrdersState();
}

var _scaffoldState = GlobalKey<ScaffoldState>();

class _AllOrdersState extends State<AllOrders> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
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
                icon: const Icon(Icons.menu)),
            elevation: 0,
            title: const Text("Все заказы"),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              shrinkWrap: true,
              children: [
                FutureBuilder<List<Order>>(
                    future: OrderApi().getAllOrders(),
                    builder: (context, snap) {
                      bool checkConnection =
                          snap.connectionState == ConnectionState.done;
                      if (!checkConnection) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      } else if (snap.hasError) {
                        return Text("errors : ${snap.error}");
                      } else if (snap.data!.isEmpty) {
                        return const Center(child: Text("Пока пусто"));
                      } else {
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snap.data!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (cotnext) =>
                                              OrderDetailProduct(
                                                  orderId:
                                                      snap.data![index].id!)));
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
                                                Text(
                                                  "Итог: ${snap.data![index].total}c",
                                                  style: TextStyle(
                                                      fontSize:
                                                          Dimensions.size20),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Количество: ${snap.data![index].qtyOfProducts}",
                                                      style: TextStyle(
                                                          fontSize: Dimensions
                                                              .size16),
                                                    ),
                                                    Text(
                                                      DateFormat.yMMMMd('RU')
                                                          .format(DateTime
                                                              .parse(snap
                                                                  .data![index]
                                                                  .dateTime!
                                                                  .substring(
                                                                      0, 10))),
                                                      style: TextStyle(
                                                          fontSize: Dimensions
                                                                  .size14 -
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
                            });
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
