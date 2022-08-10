import 'dart:ui';

import 'package:delivery_food_app_from_behance1/api/product_api/product_api.dart';
import 'package:delivery_food_app_from_behance1/models/product.dart';
import 'package:flutter/material.dart';

import '../utils/dimension.dart';

class OrderDetailProduct extends StatelessWidget {
  int orderId;
  OrderDetailProduct({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: FutureBuilder<List<Product>>(
          future: ProductApi().getProductList(orderId),
          builder: (context, snap) {
            bool connect = snap.connectionState == ConnectionState.done;
            if (!connect) {
              return const CircularProgressIndicator(
                color: Colors.white,
              );
            } else if (snap.hasError) {
              return Text("${snap.error}");
            } else if (snap.data == null) {
              return Text("Пока пусто",
                  style: TextStyle(fontSize: Dimensions.size14));
            } else if (snap.data!.isEmpty) {
              return Text("Пока пусто",
                  style: TextStyle(fontSize: Dimensions.size14));
            } else {
              return ListView.builder(
                  itemCount: snap.data!.length,
                  itemBuilder: (context, index) {
                    double total =
                        snap.data![index].quantity! * snap.data![index].price!;
                    return Padding(
                      padding: EdgeInsets.only(
                          left: Dimensions.size30, right: Dimensions.size30),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: Dimensions.size18 * 10,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.size10)),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                left: 0,
                                child: Container(
                                  height: Dimensions.size50 * 3,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[800],
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.size10)),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: Dimensions.size20,
                                right: 0,
                                top: 0,
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: Dimensions.size10 * 10,
                                        height: Dimensions.size10 * 10,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.size70),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    '${snap.data![index].image}'))),
                                      ),
                                      SizedBox(
                                        width: Dimensions.size15,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            top: Dimensions.size50,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // ignore: prefer_const_constructors
                                              Text(
                                                "${snap.data![index].name}",
                                                style: TextStyle(
                                                    fontSize:
                                                        Dimensions.size16),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  'No.1 in Sales',
                                                  style: TextStyle(
                                                    fontSize:
                                                        Dimensions.size14 - 1,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "Количество заказа: ${snap.data![index].quantity}",
                                                  style: TextStyle(
                                                      fontSize:
                                                          Dimensions.size16),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "Цена: ${total.toStringAsFixed(2)}",
                                                  style: TextStyle(
                                                      fontSize:
                                                          Dimensions.size16),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: Dimensions.size20,
                          )
                        ],
                      ),
                    );
                  });
            }
          }),
    );
  }
}
