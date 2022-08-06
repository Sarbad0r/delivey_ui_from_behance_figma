import 'package:delivery_food_app_from_behance1/log_and_reg/login_page.dart';
import 'package:delivery_food_app_from_behance1/pages/category_page.dart';
import 'package:delivery_food_app_from_behance1/pages/menu_page.dart';
import 'package:delivery_food_app_from_behance1/state_menagement_provider/cart_provider.dart';
import 'package:delivery_food_app_from_behance1/utils/shared_prefer.dart';
import 'package:delivery_food_app_from_behance1/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPrefer.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider())
    ],
    child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: LoadingScreen(),
    ),
  ));
}
