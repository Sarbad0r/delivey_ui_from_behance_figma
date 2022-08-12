import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/product_about_page.dart';
import '../state_menagement_provider/cart_provider.dart';
import '../utils/dimension.dart';

class RecommendedMenuPage extends StatelessWidget {
  const RecommendedMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);

    return Padding(
      padding:
          EdgeInsets.only(right: Dimensions.size30, left: Dimensions.size30),
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
                        height: Dimensions.size18 * 10,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.size10)),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                          height: Dimensions.size50 * 3,
                          decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius:
                                  BorderRadius.circular(Dimensions.size10)),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: Dimensions.size20,
                        right: 0,
                        top: 0,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Hero(
                                tag:
                                    "${cutSpace(cartProvider.listOfProduct[index].name!)}",
                                child: Container(
                                  width: Dimensions.size10 * 10,
                                  height: Dimensions.size10 * 10,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.size70),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              '${cartProvider.listOfProduct[index].image}'))),
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
                                        "${cartProvider.listOfProduct[index].name}",
                                        style: TextStyle(
                                            fontSize: Dimensions.size16),
                                      ),
                                      Expanded(
                                        child: Text(
                                          'No.1 in Sales',
                                          style: TextStyle(
                                            fontSize: Dimensions.size14 - 1,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "\$${cartProvider.listOfProduct[index].price!.toStringAsFixed(2)}",
                                          style: TextStyle(
                                              fontSize: Dimensions.size16),
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
                                    if (!cartProvider.checkProductFavorite(
                                        cartProvider.listOfProduct[index]))
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: Dimensions.size30),
                                        child: IconButton(
                                            onPressed: () {
                                              cartProvider.addToFavorite(
                                                  cartProvider
                                                      .listOfProduct[index]);
                                            },
                                            icon: Icon(
                                              Icons.favorite_border,
                                              size: Dimensions.size25,
                                            )),
                                      )
                                    else
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: Dimensions.size30),
                                        child: IconButton(
                                            onPressed: () {
                                              cartProvider.addToFavorite(
                                                  cartProvider
                                                      .listOfProduct[index]);
                                            },
                                            icon: Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                              size: Dimensions.size25,
                                            )),
                                      ),
                                    if (!cartProvider.checkProductCart(
                                        cartProvider.listOfProduct[index]))
                                      IconButton(
                                          onPressed: () {
                                            cartProvider.addToCart(cartProvider
                                                .listOfProduct[index]);
                                          },
                                          icon: Icon(
                                            Icons.add_circle_outlined,
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
                                                  Icons.remove_circle_outline,
                                                  color: Colors.grey[500],
                                                  size: Dimensions.size25,
                                                )),
                                          ),
                                          Text(
                                            "${cartProvider.listOfProduct[index].quantity}",
                                            style: TextStyle(
                                                fontSize: Dimensions.size18),
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
                                                  Icons.add_circle_outlined,
                                                  size: Dimensions.size25,
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
          }),
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
