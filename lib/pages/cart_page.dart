import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../state_menagement_provider/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
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
                  badgeColor: Colors.green,
                  badgeContent: Text(
                    "${cartProvider.cartProductList.length}",
                    style: const TextStyle(fontSize: 10),
                  ),
                  child: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.shopping_cart)),
                )
              ],
            ),
          ),
          Expanded(
              child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                ),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "Hi, Kate",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.location_on_outlined,
                            size: 25,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('8 people online',
                          style: TextStyle(color: Colors.green[300])),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Your order: ",
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            "Total: \$${cartProvider.totalOfCart()}",
                            style: const TextStyle(
                                fontSize: 18, color: Colors.yellow),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      for (var each in cartProvider.cartProductList)
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${each.name}  ",
                                  style: const TextStyle(fontSize: 18),
                                ),
                                Text(
                                  "x${each.quantity}",
                                  style: const TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      SizedBox(
                        height: 30,
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
                                      height: 180,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      left: 0,
                                      child: Container(
                                        height: 150,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[800],
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 20,
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
                                              width: 130,
                                              height: 130,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(70),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: AssetImage(
                                                          '${cartProvider.cartProductList[index].image}'))),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 50,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // ignore: prefer_const_constructors
                                                    Text(
                                                      "${cartProvider.cartProductList[index].name}",
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                    const Expanded(
                                                      child: Text(
                                                        'No.1 in Sales',
                                                        style: TextStyle(
                                                            fontSize: 13),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "\$${cartProvider.cartProductList[index].price!.toStringAsFixed(2)}",
                                                        style: TextStyle(
                                                            fontSize: 16),
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
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 30),
                                                      child: IconButton(
                                                          onPressed: () {
                                                            cartProvider
                                                                .addToFavorite(
                                                                    cartProvider
                                                                            .cartProductList[
                                                                        index]);
                                                          },
                                                          icon: const Icon(Icons
                                                              .favorite_border)),
                                                    )
                                                  else
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 30),
                                                      child: IconButton(
                                                          onPressed: () {
                                                            cartProvider
                                                                .addToFavorite(
                                                                    cartProvider
                                                                            .cartProductList[
                                                                        index]);
                                                          },
                                                          icon: const Icon(
                                                            Icons.favorite,
                                                            color: Colors.red,
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
                                                        icon: const Icon(Icons
                                                            .add_circle_outlined))
                                                  else
                                                    Row(
                                                      children: [
                                                        IconButton(
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
                                                            )),
                                                        Text(
                                                            "${cartProvider.cartProductList[index].quantity}"),
                                                        Expanded(
                                                          child: IconButton(
                                                              onPressed: () {
                                                                cartProvider.addToCart(
                                                                    cartProvider
                                                                            .cartProductList[
                                                                        index]);
                                                              },
                                                              icon: const Icon(Icons
                                                                  .add_circle_outlined)),
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
                                const SizedBox(
                                  height: 20,
                                )
                              ],
                            );
                          })
                    ],
                  ),
                ),
              )
            ],
          )),
          if (cartProvider.cartProductList.isNotEmpty)
            InkWell(
              onTap: () {},
              child: Container(
                width: 140,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.green[300],
                    borderRadius: BorderRadius.circular(50)),
                child: const Center(
                    child: Text(
                  "Pay",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
              ),
            )
        ]));
  }
}
