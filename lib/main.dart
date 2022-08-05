import 'package:delivery_food_app_from_behance1/pages/category_page.dart';
import 'package:delivery_food_app_from_behance1/pages/menu_page.dart';
import 'package:delivery_food_app_from_behance1/state_menagement_provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider())
    ],
    child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: CategoryPage(),
    ),
  ));
}
