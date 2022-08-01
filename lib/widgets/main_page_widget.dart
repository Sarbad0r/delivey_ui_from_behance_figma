import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/product_about_page.dart';
import '../state_menagement_provider/cart_provider.dart';

class MenuPageWidget extends StatelessWidget {
  const MenuPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    return Expanded(
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
          Stack(
            children: [
              Container(
                height: 120,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image:
                            AssetImage('assets/images/murakami_welcome.jpg'))),
              ),
              Container(
                height: 120,
                color: Colors.black.withOpacity(0.4),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 60, right: 60),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "WELCOME TO MURAKAMI",
                              style: TextStyle(letterSpacing: 2, fontSize: 18),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 85,
                              height: 22,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Center(
                                child: Text(
                                  "20-30 min",
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ),
                            const Text("2.4 km"),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow[700],
                                  size: 15,
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                const Text("4.7"),
                              ],
                            ),
                            const Text("Sushi 1")
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 130,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(40)),
                  child: const Center(
                      child: Text(
                    "Recommended",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 90,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: BorderRadius.circular(40)),
                  child: const Center(
                      child: Text(
                    "Popular",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 80,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: BorderRadius.circular(40)),
                  child: const Center(
                      child: Text(
                    "Sushi",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30, left: 30),
            child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cartProvider.listOfProduct.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductAboutPage(
                                    product: cartProvider.listOfProduct[index],
                                  )));
                    },
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 180,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: Container(
                                height: 150,
                                decoration: BoxDecoration(
                                    color: Colors.grey[800],
                                    borderRadius: BorderRadius.circular(10)),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Hero(
                                      tag:
                                          "${cutSpace(cartProvider.listOfProduct[index].name!)}",
                                      child: Container(
                                        width: 130,
                                        height: 130,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(70),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    '${cartProvider.listOfProduct[index].image}'))),
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
                                              "${cartProvider.listOfProduct[index].name}",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            const Expanded(
                                              child: Text(
                                                'No.1 in Sales',
                                                style: TextStyle(fontSize: 13),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                "\$${cartProvider.listOfProduct[index].price!.toStringAsFixed(2)}",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          if (!cartProvider
                                              .checkProductFavorite(cartProvider
                                                  .listOfProduct[index]))
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 30),
                                              child: IconButton(
                                                  onPressed: () {
                                                    cartProvider.addToFavorite(
                                                        cartProvider
                                                                .listOfProduct[
                                                            index]);
                                                  },
                                                  icon: const Icon(
                                                      Icons.favorite_border)),
                                            )
                                          else
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 30),
                                              child: IconButton(
                                                  onPressed: () {
                                                    cartProvider.addToFavorite(
                                                        cartProvider
                                                                .listOfProduct[
                                                            index]);
                                                  },
                                                  icon: const Icon(
                                                    Icons.favorite,
                                                    color: Colors.red,
                                                  )),
                                            ),
                                          if (!cartProvider.checkProductCart(
                                              cartProvider
                                                  .listOfProduct[index]))
                                            IconButton(
                                                onPressed: () {
                                                  cartProvider.addToCart(
                                                      cartProvider
                                                              .listOfProduct[
                                                          index]);
                                                },
                                                icon: const Icon(
                                                    Icons.add_circle_outlined))
                                          else
                                            Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      cartProvider.removeFromCart(
                                                          cartProvider
                                                                  .listOfProduct[
                                                              index]);
                                                    },
                                                    icon: Icon(
                                                      Icons
                                                          .remove_circle_outline,
                                                      color: Colors.grey[500],
                                                    )),
                                                Text(
                                                    "${cartProvider.listOfProduct[index].quantity}"),
                                                Expanded(
                                                  child: IconButton(
                                                      onPressed: () {
                                                        cartProvider.addToCart(
                                                            cartProvider
                                                                    .listOfProduct[
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
                }),
          )
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
