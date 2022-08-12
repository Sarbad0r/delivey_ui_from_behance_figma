import 'package:delivery_food_app_from_behance1/api/order_api/order_api.dart';
import 'package:delivery_food_app_from_behance1/log_and_reg/login_page.dart';
import 'package:delivery_food_app_from_behance1/log_and_reg/register_page.dart';
import 'package:delivery_food_app_from_behance1/pages/category_page.dart';
import 'package:delivery_food_app_from_behance1/pages/menu_page.dart';
import 'package:delivery_food_app_from_behance1/state_menagement_provider/cart_provider.dart';
import 'package:delivery_food_app_from_behance1/state_menagement_provider/side_bar_page.dart';
import 'package:delivery_food_app_from_behance1/utils/shared_prefer.dart';
import 'package:delivery_food_app_from_behance1/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPrefer.init();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<OrderApi>(create: (_) => OrderApi()),
      ChangeNotifierProvider<SideBarPage>(create: (_) => SideBarPage()),
      ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider())
    ],
    child: GetMaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ru', ''),
      ],
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: LoadingScreen(),
    ),
  ));
}
