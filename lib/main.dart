import 'package:delivery_food_app_from_behance1/pages/menu_page.dart';
import 'package:delivery_food_app_from_behance1/state_menagement_provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider())
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: MenuPage(),
    ),
  ));
}
