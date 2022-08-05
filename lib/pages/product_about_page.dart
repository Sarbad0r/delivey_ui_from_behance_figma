import 'package:badges/badges.dart';
import 'package:delivery_food_app_from_behance1/models/product.dart';
import 'package:delivery_food_app_from_behance1/state_menagement_provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../utils/dimension.dart';
import 'cart_page.dart';

class ProductAboutPage extends StatefulWidget {
  Product? product;

  ProductAboutPage({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductAboutPage> createState() => _ProductAboutPageState();
}

class _ProductAboutPageState extends State<ProductAboutPage> {
  TextEditingController _searchController = TextEditingController(text: '');

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

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    height: Dimensions.size70 / 2,
                    child: Stack(
                      children: [
                        TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  top: 4, left: Dimensions.size15),
                              prefixIcon: const Icon(Icons.search),
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
                                    });
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
                                builder: (context) => const CartPage()));
                      },
                      icon: const Icon(Icons.shopping_cart)),
                )
              ],
            ),
          ),
          SizedBox(
            height: Dimensions.size15,
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
                      Container(
                        width: Dimensions.size50,
                        height: Dimensions.size50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(Dimensions.size30)),
                      ),
                      SizedBox(
                        width: Dimensions.size10,
                      ),
                      Text(
                        "Hi, Kate",
                        style: TextStyle(
                          fontSize: Dimensions.size18,
                        ),
                      ),
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
                    height: Dimensions.size25,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                  left: Dimensions.size20, right: Dimensions.size20),
              child: Stack(
                children: [
                  Container(),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      height: (MediaQuery.of(context).size.height / 2) +
                          Dimensions.size15 * 10,
                      decoration: BoxDecoration(
                          color: Colors.grey[700],
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.size10))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: Dimensions.size30, right: Dimensions.size30),
                    child: Container(
                      width: double.maxFinite,
                      child: Column(
                        children: [
                          Hero(
                            tag: "${cutSpace(widget.product!.name!)}",
                            child: Container(
                              width: Dimensions.size10 * 13,
                              height: Dimensions.size10 * 13,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(Dimensions.size100),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          '${widget.product!.image}'))),
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.size10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${widget.product!.name}",
                                style: TextStyle(fontSize: Dimensions.size30),
                              ),
                              if (!cartProvider
                                  .checkProductFavorite(widget.product!))
                                IconButton(
                                    onPressed: () {
                                      cartProvider
                                          .addToFavorite(widget.product!);
                                    },
                                    icon: const Icon(Icons.favorite_border))
                              else
                                IconButton(
                                    onPressed: () {
                                      cartProvider
                                          .addToFavorite(widget.product!);
                                    },
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ))
                            ],
                          ),
                          SizedBox(
                            height: Dimensions.size20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: Dimensions.size15,
                                right: Dimensions.size15),
                            child: Container(
                              height: Dimensions.size50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(Dimensions.size50)),
                                  color: Colors.black),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: Dimensions.size15,
                                    right: Dimensions.size15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "\$${widget.product!.price}",
                                      style: TextStyle(
                                          color: HexColor('e3b100'),
                                          fontSize: Dimensions.size20),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              cartProvider.removeFromCart(
                                                  widget.product!);
                                            },
                                            icon: const Icon(
                                              Icons.remove_circle_outline,
                                              color: Colors.grey,
                                            )),
                                        Text("${widget.product!.quantity}"),
                                        IconButton(
                                            onPressed: () {
                                              cartProvider
                                                  .addToCart(widget.product!);
                                            },
                                            icon: const Icon(
                                              Icons.add_circle,
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.size10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.timer),
                                  SizedBox(
                                    width: Dimensions.size10,
                                  ),
                                  const Text("8 min")
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.light),
                                  SizedBox(
                                    width: Dimensions.size10,
                                  ),
                                  const Text("345 kal")
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.check),
                                  SizedBox(
                                    width: Dimensions.size10,
                                  ),
                                  const Text("Top")
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: Dimensions.size20,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "About",
                              style: TextStyle(fontSize: Dimensions.size18),
                            ),
                          ),
                          ListView(
                            shrinkWrap: true,
                            children: [
                              Wrap(
                                children: [
                                  Text(
                                    "${widget.product!.about}",
                                    style:
                                        TextStyle(fontSize: Dimensions.size18),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Expanded(child: Container()),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: Dimensions.size15 * 10,
                                  height: Dimensions.size50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.size50),
                                      color: HexColor("2db45b")),
                                  child: Center(
                                    child: Text(
                                      "Pay",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Dimensions.size18),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (cartProvider
                                        .checkProductCart(widget.product!)) {
                                      Get.snackbar("Уведомление",
                                          "Продукт уже был добавлен в корзину");
                                    } else {
                                      cartProvider.addToCart(widget.product!);
                                    }
                                  },
                                  child: Container(
                                    width: Dimensions.size80,
                                    height: Dimensions.size50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.size50),
                                        color: Colors.white),
                                    child: Center(
                                      child: Icon(
                                        Icons.shopping_cart,
                                        color: HexColor("2db45b"),
                                      ),
                                    ),
                                  ),
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
            ),
          )
        ],
      ),
    );
  }
}
