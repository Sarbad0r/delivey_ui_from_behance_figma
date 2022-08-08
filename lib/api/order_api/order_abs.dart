import 'package:delivery_food_app_from_behance1/models/order.dart';

abstract class AbsOrder {
  Future<List<Order>> getAllOrders(int userId);
  Future<void> deleteOrder();
}
