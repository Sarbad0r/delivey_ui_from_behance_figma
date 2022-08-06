import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:provider/provider.dart';

import '../pages/product_about_page.dart';
import '../state_menagement_provider/cart_provider.dart';
import '../utils/dimension.dart';

class MenuPageWidget extends StatefulWidget {
  const MenuPageWidget({Key? key}) : super(key: key);

  @override
  State<MenuPageWidget> createState() => _MenuPageWidgetState();
}

class _MenuPageWidgetState extends State<MenuPageWidget> {
  int _selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: [
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
          Stack(
            children: [
              Container(
                height: Dimensions.size120,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image:
                            AssetImage('assets/images/murakami_welcome.jpg'))),
              ),
              Container(
                height: Dimensions.size120,
                color: Colors.black.withOpacity(0.4),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "WELCOME TO MURAKAMI",
                            style: TextStyle(
                                letterSpacing: 2, fontSize: Dimensions.size18),
                          )
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.size10 - 7,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: Dimensions.size50,
                            right: Dimensions.size50,
                            top: Dimensions.size10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: Dimensions.size80 + 5,
                              height: Dimensions.size20 + 2,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  borderRadius:
                                      BorderRadius.circular(Dimensions.size10)),
                              child: Center(
                                child: Text(
                                  "20-30 min",
                                  style: TextStyle(
                                      fontSize: Dimensions.size14 - 1),
                                ),
                              ),
                            ),
                            Text("2.4 km",
                                style: TextStyle(fontSize: Dimensions.size16)),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow[700],
                                  size: Dimensions.size15,
                                ),
                                SizedBox(
                                  width: Dimensions.size7,
                                ),
                                Text(
                                  "4.7",
                                  style: TextStyle(fontSize: Dimensions.size16),
                                ),
                              ],
                            ),
                            Text("Sushi 1",
                                style: TextStyle(fontSize: Dimensions.size16))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: Dimensions.size20,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: Dimensions.size30, right: Dimensions.size30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: categoryWidget(),
            ),
          ),
          SizedBox(
            height: Dimensions.size20,
          ),
          if (_selectedCategory == 0)
            Padding(
              padding: EdgeInsets.only(
                  right: Dimensions.size30, left: Dimensions.size30),
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
                                      product:
                                          cartProvider.listOfProduct[index],
                                    )));
                      },
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
                                      Hero(
                                        tag:
                                            "${cutSpace(cartProvider.listOfProduct[index].name!)}",
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
                                                  "\$${cartProvider.listOfProduct[index].price!.toStringAsFixed(2)}",
                                                  style: TextStyle(
                                                      fontSize:
                                                          Dimensions.size16),
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
                                                .checkProductFavorite(
                                                    cartProvider
                                                        .listOfProduct[index]))
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: Dimensions.size30),
                                                child: IconButton(
                                                    onPressed: () {
                                                      cartProvider.addToFavorite(
                                                          cartProvider
                                                                  .listOfProduct[
                                                              index]);
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
                                                                  .listOfProduct[
                                                              index]);
                                                    },
                                                    icon: Icon(
                                                      Icons.favorite,
                                                      color: Colors.red,
                                                      size: Dimensions.size25,
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
                                                          cartProvider
                                                              .removeFromCart(
                                                                  cartProvider
                                                                          .listOfProduct[
                                                                      index]);
                                                        },
                                                        icon: Icon(
                                                          Icons
                                                              .remove_circle_outline,
                                                          color:
                                                              Colors.grey[500],
                                                          size:
                                                              Dimensions.size25,
                                                        )),
                                                  ),
                                                  Text(
                                                    "${cartProvider.listOfProduct[index].quantity}",
                                                    style: TextStyle(
                                                        fontSize:
                                                            Dimensions.size18),
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
                                                          size:
                                                              Dimensions.size25,
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

  List<Widget> categoryWidget() {
    return [
      GestureDetector(
        onTap: () {
          setState(() {
            _selectedCategory = 0;
          });
        },
        child: Row(
          children: [
            Container(
              width: Dimensions.size10 * 13,
              height: Dimensions.size30,
              decoration: BoxDecoration(
                  color: _selectedCategory == 0
                      ? HexColor('2db45b')
                      : Colors.grey[700],
                  borderRadius: BorderRadius.circular(Dimensions.size40)),
              child: Center(
                  child: Text(
                "Recommended",
                style: TextStyle(
                    fontSize: Dimensions.size16, fontWeight: FontWeight.bold),
              )),
            ),
            SizedBox(
              width: Dimensions.size10,
            )
          ],
        ),
      ),
      GestureDetector(
        onTap: () {
          setState(() {
            _selectedCategory = 1;
          });
        },
        child: Row(
          children: [
            Container(
              width: Dimensions.size30 * 3,
              height: Dimensions.size30,
              decoration: BoxDecoration(
                  color: _selectedCategory == 1
                      ? HexColor('2db45b')
                      : Colors.grey[700],
                  borderRadius: BorderRadius.circular(Dimensions.size40)),
              child: Center(
                  child: Text(
                "Popular",
                style: TextStyle(
                    fontSize: Dimensions.size16, fontWeight: FontWeight.bold),
              )),
            ),
            SizedBox(
              width: Dimensions.size10,
            )
          ],
        ),
      ),
      Expanded(
        child: GestureDetector(
          onTap: () {
            setState(() {
              _selectedCategory = 2;
            });
          },
          child: Container(
            width: Dimensions.size80,
            height: Dimensions.size30,
            decoration: BoxDecoration(
                color: _selectedCategory == 2
                    ? HexColor('2db45b')
                    : Colors.grey[700],
                borderRadius: BorderRadius.circular(Dimensions.size40)),
            child: Center(
                child: Text(
              "Sushi",
              style: TextStyle(
                  fontSize: Dimensions.size16, fontWeight: FontWeight.bold),
            )),
          ),
        ),
      )
    ];
  }
}
