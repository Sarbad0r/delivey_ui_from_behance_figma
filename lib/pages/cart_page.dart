import 'package:badges/badges.dart';
import 'package:delivery_food_app_from_behance1/api/order_api/order_api.dart';
import 'package:delivery_food_app_from_behance1/models/order.dart';
import 'package:delivery_food_app_from_behance1/pages/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:provider/provider.dart';
import '../api/api_connections.dart';
import '../state_menagement_provider/cart_provider.dart';
import '../utils/dimension.dart';
import '../utils/shared_prefer.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String street = '';
  void updateParent(String nameStreet) {
    setState(() {
      street = nameStreet;
    });
  }

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(children: [
          SizedBox(
            height: Dimensions.size50,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: Dimensions.size10, right: Dimensions.size10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)),
                Badge(
                  elevation: 0,
                  position: BadgePosition.topEnd(end: 2, top: 0),
                  animationType: BadgeAnimationType.slide,
                  showBadge:
                      cartProvider.cartProductList.isEmpty ? false : true,
                  badgeColor: HexColor("2db45b"),
                  badgeContent: Text(
                    "${cartProvider.cartProductList.length}",
                    style: TextStyle(fontSize: Dimensions.size10),
                  ),
                  child: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.shopping_cart)),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: Dimensions.size30,
            ),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.size30),
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
                          builder: ((context, snapshot) => Text(
                                "Hi, ${snapshot.data}",
                                style: TextStyle(
                                  fontSize: Dimensions.size18,
                                ),
                              ))),
                      SizedBox(
                        width: Dimensions.size10,
                      ),
                      Icon(
                        Icons.location_on_outlined,
                        size: Dimensions.size25,
                      )
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.size10,
                  ),
                  Text('8 people online',
                      style: TextStyle(color: HexColor("2db45b"))),
                  SizedBox(
                    height: Dimensions.size10,
                  ),
                ],
              ),
            ),
          ),
          if (street.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(
                  left: Dimensions.size30, right: Dimensions.size30),
              child: Row(
                children: [
                  Text(
                    street,
                    style: TextStyle(fontSize: Dimensions.size14),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          street = '';
                        });
                      },
                      icon: Icon(Icons.delete))
                ],
              ),
            ),
          SizedBox(
            height: Dimensions.size10,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                  left: Dimensions.size30, right: Dimensions.size30),
              child: Container(
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Your order: ",
                          style: TextStyle(fontSize: Dimensions.size18),
                        ),
                        Text(
                          "Total: \$${cartProvider.totalOfCart()}",
                          style: TextStyle(
                              fontSize: Dimensions.size18,
                              color: HexColor('e3b100')),
                        )
                      ],
                    ),
                    SizedBox(height: Dimensions.size10),
                    for (var each in cartProvider.cartProductList)
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "${each.name}  ",
                                style: TextStyle(fontSize: Dimensions.size18),
                              ),
                              Text(
                                "x${each.quantity}",
                                style: const TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          SizedBox(
                            height: Dimensions.size10,
                          )
                        ],
                      ),
                    SizedBox(
                      height: Dimensions.size30,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cartProvider.cartProductList.length,
                        itemBuilder: (context, index) {
                          return Column(
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
                                      height: Dimensions.size15 * 10,
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
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.size70),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                        '${cartProvider.cartProductList[index].image}'))),
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
                                                    "${cartProvider.cartProductList[index].name}",
                                                    style: TextStyle(
                                                        fontSize:
                                                            Dimensions.size16),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      'No.1 in Sales',
                                                      style: TextStyle(
                                                          fontSize: Dimensions
                                                                  .size14 -
                                                              1),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      "\$${cartProvider.cartProductList[index].price!.toStringAsFixed(2)}",
                                                      style: TextStyle(
                                                          fontSize: Dimensions
                                                              .size16),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                if (!cartProvider
                                                    .checkProductFavorite(
                                                        cartProvider
                                                                .cartProductList[
                                                            index]))
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: Dimensions.size30),
                                                    child: IconButton(
                                                        onPressed: () {
                                                          cartProvider
                                                              .addToFavorite(
                                                                  cartProvider
                                                                          .cartProductList[
                                                                      index]);
                                                        },
                                                        icon: Icon(
                                                          Icons.favorite_border,
                                                          size:
                                                              Dimensions.size25,
                                                        )),
                                                  )
                                                else
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: Dimensions.size30),
                                                    child: IconButton(
                                                        onPressed: () {
                                                          cartProvider
                                                              .addToFavorite(
                                                                  cartProvider
                                                                          .cartProductList[
                                                                      index]);
                                                        },
                                                        icon: Icon(
                                                          Icons.favorite,
                                                          color: Colors.red,
                                                          size:
                                                              Dimensions.size25,
                                                        )),
                                                  ),
                                                if (!cartProvider
                                                    .checkProductCart(
                                                        cartProvider
                                                                .cartProductList[
                                                            index]))
                                                  IconButton(
                                                      onPressed: () {
                                                        cartProvider.addToCart(
                                                            cartProvider
                                                                    .cartProductList[
                                                                index]);
                                                      },
                                                      icon: Icon(
                                                        Icons
                                                            .add_circle_outlined,
                                                        size: Dimensions.size25,
                                                      ))
                                                else
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: IconButton(
                                                            onPressed: () {
                                                              cartProvider.removeFromCart(
                                                                  cartProvider
                                                                          .cartProductList[
                                                                      index]);
                                                            },
                                                            icon: Icon(
                                                              Icons
                                                                  .remove_circle_outline,
                                                              color: Colors
                                                                  .grey[500],
                                                              size: Dimensions
                                                                  .size25,
                                                            )),
                                                      ),
                                                      Text(
                                                        "${cartProvider.cartProductList[index].quantity}",
                                                        style: TextStyle(
                                                            fontSize: Dimensions
                                                                .size18),
                                                      ),
                                                      Expanded(
                                                        child: IconButton(
                                                            onPressed: () {
                                                              cartProvider.addToCart(
                                                                  cartProvider
                                                                          .cartProductList[
                                                                      index]);
                                                            },
                                                            icon: Icon(
                                                              Icons
                                                                  .add_circle_outlined,
                                                              size: Dimensions
                                                                  .size25,
                                                            )),
                                                      )
                                                    ],
                                                  )
                                              ],
                                            ),
                                          )
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
                          );
                        })
                  ],
                ),
              ),
            ),
          ),
          if (cartProvider.cartProductList.isNotEmpty)
            InkWell(
              onTap: () async {
                if (street.isEmpty) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReverseSearchPage(
                                getParentState: updateParent,
                              )));
                } else {
                  EasyLoading.show(status: "Оформляем заказ");
                  var order = Order(
                      userId: await SharedPrefer().getUserID(),
                      qtyOfProducts: cartProvider.totalQty(),
                      total: cartProvider.totalOfCart(),
                      productList: cartProvider.cartProductList,
                      address: street);
                  await OrderApi().setOrderAndProduct(order).then((value) {
                    if (value == true) {
                      EasyLoading.showSuccess("Все!");
                      setState(() {
                        street = '';
                      });
                      cartProvider.clearCart();
                    }
                  });
                }
              },
              child: Container(
                width: Dimensions.size10 * 14,
                height: Dimensions.size50,
                decoration: BoxDecoration(
                    color: HexColor("2db45b"),
                    borderRadius: BorderRadius.circular(Dimensions.size50)),
                child: Center(
                    child: Text(
                  "Pay",
                  style: TextStyle(
                      fontSize: Dimensions.size18, fontWeight: FontWeight.bold),
                )),
              ),
            )
        ]));
  }
}
