import 'package:flutter/cupertino.dart';

class CartProvider extends ChangeNotifier {
  int n = 0;
  void add() {
    n++;
    notifyListeners();
  }
  void remove(){
    n = 0;
    notifyListeners();
  }
}
