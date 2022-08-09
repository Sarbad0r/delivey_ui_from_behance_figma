import 'package:delivery_food_app_from_behance1/models/product.dart';

abstract class ProductAbs {
  Future<List<Product>> getProductList(int orderId);
}
