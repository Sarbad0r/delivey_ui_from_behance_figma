import 'package:badges/badges.dart';
import 'package:delivery_food_app_from_behance1/pages/cart_page.dart';
import 'package:delivery_food_app_from_behance1/pages/product_about_page.dart';
import 'package:delivery_food_app_from_behance1/state_menagement_provider/cart_provider.dart';
import 'package:delivery_food_app_from_behance1/utils/dimension.dart';
import 'package:delivery_food_app_from_behance1/widgets/main_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
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
            height: Dimensions.size50,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: Dimensions.size10, right: Dimensions.size10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(
                      left: Dimensions.size5, right: Dimensions.size5),
                  child: Container(
                    height: Dimensions.size30 + 5,
                    child: Stack(
                      children: [
                        TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                top: 4,
                                left: Dimensions.size15,
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                size: Dimensions.size25,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1.0),
                                  borderRadius:
                                      BorderRadius.circular(Dimensions.size20)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1.0),
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.size20))),
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
                                    size: Dimensions.size20,
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
                  badgeColor: HexColor("2db45b"),
                  badgeContent: Text(
                    "${cartProvider.cartProductList.length}",
                    style: TextStyle(fontSize: Dimensions.size10),
                  ),
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CartPage()));
                      },
                      icon: Icon(
                        Icons.shopping_cart,
                        size: Dimensions.size25,
                      )),
                )
              ],
            ),
          ),
          SizedBox(
            height: Dimensions.size20,
          ),
          if (listForSearch.isNotEmpty)
            Expanded(
              child: Padding(
                  padding: EdgeInsets.only(
                    right: Dimensions.size30,
                    left: Dimensions.size30,
                  ),
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
                                    height: Dimensions.size10 * 18,
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
                                          Hero(
                                            tag: cutSpace(
                                                listForSearch[index].name!),
                                            child: Container(
                                              width: Dimensions.size10 * 11,
                                              height: Dimensions.size10 * 11,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions.size70),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: AssetImage(
                                                          '${listForSearch[index].image}'))),
                                            ),
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
                                                    "${listForSearch[index].name}",
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
                                                      "\$${listForSearch[index].price!.toStringAsFixed(2)}",
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
                                                                .listOfProduct[
                                                            index]))
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: Dimensions.size30),
                                                    child: IconButton(
                                                        onPressed: () {
                                                          cartProvider
                                                              .addToFavorite(
                                                                  cartProvider
                                                                          .listOfProduct[
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
                                                                          .listOfProduct[
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
                                                                .listOfProduct[
                                                            index]))
                                                  IconButton(
                                                      onPressed: () {
                                                        cartProvider.addToCart(
                                                            cartProvider
                                                                    .listOfProduct[
                                                                index]);
                                                      },
                                                      icon: Icon(
                                                        Icons
                                                            .add_circle_outlined,
                                                        size: Dimensions.size25,
                                                      ))
                                                else
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        child: IconButton(
                                                            onPressed: () {
                                                              cartProvider.removeFromCart(
                                                                  cartProvider
                                                                          .listOfProduct[
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
                                                        "${cartProvider.listOfProduct[index].quantity}",
                                                        style: TextStyle(
                                                            fontSize: Dimensions
                                                                .size18),
                                                      ),
                                                      Expanded(
                                                        child: IconButton(
                                                            onPressed: () {
                                                              cartProvider.addToCart(
                                                                  cartProvider
                                                                          .listOfProduct[
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
