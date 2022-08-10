import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';

import '../api/api_connections.dart';
import '../models/category.dart';
import '../pages/menu_page.dart';
import '../utils/dimension.dart';
import '../utils/shared_prefer.dart';

class CategoryPageWidget extends StatefulWidget {
  CategoryPageWidget({Key? key}) : super(key: key);

  @override
  State<CategoryPageWidget> createState() => _CategoryPageWidgetState();
}

class _CategoryPageWidgetState extends State<CategoryPageWidget> {
  final ScrollController _firstController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: Dimensions.size30, right: Dimensions.size30),
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
                    height: Dimensions.size25,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Choose your restaurant",
                      style: TextStyle(
                          fontSize: Dimensions.size25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.size20,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                  left: Dimensions.size30, right: Dimensions.size30),
              child: Scrollbar(
                thickness: 1,
                controller: _firstController,
                child: ListView.builder(
                    controller: _firstController,
                    itemCount: Category.getListOfCategory().length,
                    itemBuilder: (context, index) {
                      var eachCategory = Category.getListOfCategory()[index];

                      List<String> categoryName = [
                        ...addEachNameToList(eachCategory.countryCuisine!)
                      ];

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MenuPage()));
                        },
                        child: Column(
                          children: [
                            Container(
                              height: Dimensions.size15 * 11,
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        height: (Dimensions.size15 * 11) -
                                            Dimensions.size20,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    '${Category.getListOfCategory()[index].image}'))),
                                      ),
                                      Container(
                                        height: (Dimensions.size15 * 11) -
                                            Dimensions.size20,
                                        color: Colors.black.withOpacity(0.4),
                                      ),
                                      Container(
                                        width: double.maxFinite,
                                        height: (Dimensions.size15 * 11) -
                                            Dimensions.size20,
                                        child: Column(children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: Dimensions.size10,
                                                left: Dimensions.size20,
                                                right: Dimensions.size20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(
                                                      Dimensions.size5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.8),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  Dimensions
                                                                      .size7))),
                                                  child: Text(
                                                    "20-30 min",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize:
                                                            Dimensions.size15),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: HexColor('e3b100'),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  1))),
                                                  child: Center(
                                                    child: Text(
                                                      "${Category.getListOfCategory()[index].discount}%",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize:
                                                              Dimensions.size18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Center(
                                            child: Text(
                                              "${eachCategory.name}",
                                              style: TextStyle(
                                                  fontSize: Dimensions.size25,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(
                                            height: Dimensions.size10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              for (var each in categoryName)
                                                Row(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left:
                                                              Dimensions.size10,
                                                          right: Dimensions
                                                              .size10),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      Dimensions
                                                                              .size30 /
                                                                          10)),
                                                          color: Colors.white
                                                              .withOpacity(
                                                                  0.8)),
                                                      child: Center(
                                                        child: Text(
                                                          each,
                                                          style: TextStyle(
                                                              fontSize:
                                                                  Dimensions
                                                                      .size18,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: Dimensions.size10,
                                                    )
                                                  ],
                                                )
                                            ],
                                          )
                                        ]),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: Dimensions.size15,
                                          left: Dimensions.size15),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                size: Dimensions.size15 + 2,
                                                color: HexColor('e3b100'),
                                              ),
                                              SizedBox(
                                                width: Dimensions.size7,
                                              ),
                                              Text(
                                                "${eachCategory.rating}",
                                                style: TextStyle(
                                                    fontSize:
                                                        Dimensions.size15 + 2),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.car_rental,
                                                size: Dimensions.size15 + 2,
                                                color: HexColor('e3b100'),
                                              ),
                                              Text(
                                                "40 grn",
                                                style: TextStyle(
                                                    fontSize:
                                                        Dimensions.size15),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.size20,
                            )
                          ],
                        ),
                      );
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<String> addEachNameToList(String getName) {
    List<String> categoryName = [];
    String name = '';
    for (int i = 0; i < getName.length; i++) {
      if (getName[i] == ' ') {
        name += ' ';
        categoryName.add(name);
        name = '';
        continue;
      }
      if (i == getName.length - 1) {
        name += getName[getName.length - 1];
        name.trim();
        categoryName.add(name);
      }
      name += getName[i];
    }
    return categoryName;
  }
}
