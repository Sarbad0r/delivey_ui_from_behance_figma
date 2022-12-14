import 'package:delivery_food_app_from_behance1/models/order.dart';

abstract class AbsOrder {
  Future<void> getAllOrders();
  Future<void> deleteOrder();
  Future<bool> setOrderAndProduct(Order order);
}
