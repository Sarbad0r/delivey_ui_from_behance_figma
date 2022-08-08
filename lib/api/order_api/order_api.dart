import 'package:delivery_food_app_from_behance1/api/api_connections.dart';
import 'package:delivery_food_app_from_behance1/api/order_api/order_abs.dart';
import 'package:delivery_food_app_from_behance1/models/order.dart';
import 'package:http/http.dart' as http;

class OrderApi implements AbsOrder {
  @override
  Future<void> deleteOrder() {
    // TODO: implement deleteOrder
    throw UnimplementedError();
  }

  @override
  Future<List<Order>> getAllOrders(int userId) async{
    List<Order> orderList = [];
    try {
      var res = await http.get(Uri.parse("${ApiConnections.URL}//get/orders/$userId"));
    } catch (e) {
      print(e);
    }
    return orderList;
  }
}
