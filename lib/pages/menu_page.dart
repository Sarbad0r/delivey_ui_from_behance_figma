import 'package:badges/badges.dart';
import 'package:delivery_food_app_from_behance1/pages/cart_page.dart';
import 'package:delivery_food_app_from_behance1/pages/product_about_page.dart';
import 'package:delivery_food_app_from_behance1/state_menagement_provider/cart_provider.dart';
import 'package:delivery_food_app_from_behance1/widgets/main_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  TextEditingController _searchController = TextEditingController(text: '');
  List<Product> listForSearch = [];

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.arrow_back)),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Container(
                    height: 35,
                    child: Stack(
                      children: [
                        TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.only(top: 4, left: 15),
                              prefixIcon: Icon(Icons.search),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1.0),
                                  borderRadius: BorderRadius.circular(20)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1.0),
                                  borderRadius: BorderRadius.circular(20))),
                          onChanged: (v) {
                            listForSearch.clear();
                            if (_searchController.text.isEmpty) {
                              _searchController.text = '';
                              listForSearch.clear();
                              setState(() {});
                              return;
                            }
                            for (var each in cartProvider.listOfProduct) {
                              if (_searchController.text.length <=
                                  each.name!.length) {
                                if (_searchController.text
                                    .toUpperCase()
                                    .trim()
                                    .contains(each.name!
                                        .trim()
                                        .toUpperCase()
                                        .substring(
                                            0,
                                            _searchController.text
                                                .trim()
                                                .length))) {
                                  listForSearch.add(each);
                                }
                              }
                            }
                            setState(() {});
                          },
                        ),
                        if (_searchController.text.isNotEmpty)
                          Positioned(
                              bottom: -5,
                              right: 0,
                              child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _searchController.text = '';
                                      listForSearch.clear();
                                    });
                                    FocusManager.instance.primaryFocus!
                                        .unfocus();
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 20,
                                  )))
                      ],
                    ),
                  ),
                )),
                Badge(
                  elevation: 0,
                  position: BadgePosition.topEnd(end: 2, top: 0),
                  animationType: BadgeAnimationType.slide,
                  showBadge:
                      cartProvider.cartProductList.isEmpty ? false : true,
                  badgeColor: Colors.green,
                  badgeContent: Text(
                    "${cartProvider.cartProductList.length}",
                    style: TextStyle(fontSize: 10),
                  ),
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CartPage()));
                      },
                      icon: const Icon(Icons.shopping_cart)),
                )
              ],
            ),
          ),
          if (listForSearch.isNotEmpty)
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(right: 30, left: 30),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: listForSearch.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductAboutPage(
                                          product: listForSearch[index],
                                        )));
                          },
                          child: Column(
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
                                          Hero(
                                            tag:
                                                "${cutSpace(listForSearch[index].name!)}",
                                            child: Container(
                                              width: 130,
                                              height: 130,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(70),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: AssetImage(
                                                          '${listForSearch[index].image}'))),
                                            ),
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
                                                    "${listForSearch[index].name}",
                                                    style:
                                                        TextStyle(fontSize: 16),
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
                                                      "\$${listForSearch[index].price!.toStringAsFixed(2)}",
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
                                                        listForSearch[index]))
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 30),
                                                    child: IconButton(
                                                        onPressed: () {
                                                          cartProvider
                                                              .addToFavorite(
                                                                  listForSearch[
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
                                                                  listForSearch[
                                                                      index]);
                                                        },
                                                        icon: const Icon(
                                                          Icons.favorite,
                                                          color: Colors.red,
                                                        )),
                                                  ),
                                                if (!cartProvider
                                                    .checkProductCart(
                                                        listForSearch[index]))
                                                  IconButton(
                                                      onPressed: () {
                                                        cartProvider.addToCart(
                                                            listForSearch[
                                                                index]);
                                                      },
                                                      icon: const Icon(Icons
                                                          .add_circle_outlined))
                                                else
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                          onPressed: () {
                                                            cartProvider
                                                                .removeFromCart(
                                                                    listForSearch[
                                                                        index]);
                                                          },
                                                          icon: Icon(
                                                            Icons
                                                                .remove_circle_outline,
                                                            color: Colors
                                                                .grey[500],
                                                          )),
                                                      Text(
                                                          "${listForSearch[index].quantity}"),
                                                      Expanded(
                                                        child: IconButton(
                                                            onPressed: () {
                                                              cartProvider.addToCart(
                                                                  listForSearch[
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
                          ),
                        );
                      })),
            )
          else if (listForSearch.isEmpty && _searchController.text.isNotEmpty)
            Text("Пусто")
          else
            MenuPageWidget()
        ],
      ),
    );
  }

  String cutSpace(String getName) {
    String res = '';
    for (int i = 0; i < getName.length; i++) {
      if (getName[i] == ' ') {
        continue;
      }
      res += getName[i];
    }
    return res;
  }
}
