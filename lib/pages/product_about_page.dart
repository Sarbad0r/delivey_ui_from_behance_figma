import 'package:badges/badges.dart';
import 'package:delivery_food_app_from_behance1/models/product.dart';
import 'package:delivery_food_app_from_behance1/state_menagement_provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
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
          const SizedBox(
            height: 15,
          ),
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Stack(
                children: [
                  Container(),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      height: (MediaQuery.of(context).size.height / 2) + 150,
                      decoration: BoxDecoration(
                          color: Colors.grey[700],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Container(
                      width: double.maxFinite,
                      child: Column(
                        children: [
                          Hero(
                            tag: "${cutSpace(widget.product!.name!)}",
                            child: Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          '${widget.product!.image}'))),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${widget.product!.name}",
                                style: const TextStyle(fontSize: 30),
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
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Container(
                              height: 50,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  color: Colors.black),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "\$${widget.product!.price}",
                                      style: const TextStyle(
                                          color: Colors.yellow, fontSize: 20),
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
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: const [
                                  Icon(Icons.timer),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("8 min")
                                ],
                              ),
                              Row(
                                children: const [
                                  Icon(Icons.light),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("345 kal")
                                ],
                              ),
                              Row(
                                children: const [
                                  Icon(Icons.check),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Top")
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "About",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Wrap(
                            children: [
                              Text(
                                "${widget.product!.about}",
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                          Expanded(child: Container()),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 150,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.green[300]),
                                  child: Center(
                                    child: Text(
                                      "Pay",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 80,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white),
                                  child: Center(
                                    child: Icon(
                                      Icons.shopping_cart,
                                      color: Colors.green[300],
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
