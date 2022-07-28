import 'package:delivery_food_app_from_behance1/state_menagement_provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

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
                    child: TextField(
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(top: 4, left: 15),
                          hintText: "Поиск",
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0),
                              borderRadius: BorderRadius.circular(20)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0),
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                )),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.shopping_cart))
              ],
            ),
          ),
          const SizedBox(
            height: 15,
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
                Stack(
                  children: [
                    Container(
                      height: 120,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  'assets/images/murakami_welcome.jpg'))),
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
                                    style: TextStyle(
                                        letterSpacing: 2, fontSize: 18),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 85,
                                    height: 22,
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.5),
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
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
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
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
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
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
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return Column(
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
                                              image: const DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                      'assets/images/alaska_seaFood.jpg'))),
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
                                              children: const [
                                                // ignore: prefer_const_constructors
                                                Text(
                                                  "Alaska",
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    'No.1 in Sales',
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    "\$24,50\$",
                                                    style:
                                                        TextStyle(fontSize: 16),
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
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 30),
                                                child: IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                        Icons.favorite_border)),
                                              ),
                                              if (cartProvider.n == 0)
                                                IconButton(
                                                    onPressed: () {
                                                      cartProvider.add();
                                                    },
                                                    icon: const Icon(Icons
                                                        .add_circle_outlined))
                                              else
                                                Row(
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          cartProvider.remove();
                                                        },
                                                        icon: Icon(
                                                          Icons
                                                              .remove_circle_outline,
                                                          color:
                                                              Colors.grey[500],
                                                        )),
                                                    Text("${cartProvider.n}"),
                                                    Expanded(
                                                      child: IconButton(
                                                          onPressed: () {
                                                            cartProvider.add();
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
                      }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
