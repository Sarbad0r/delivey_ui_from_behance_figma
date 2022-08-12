import 'package:flutter/cupertino.dart';

class SideBarPage extends ChangeNotifier {
  int numberOfPage = 1;
  
  void setPageNumber(int number) {
    numberOfPage = number;
    notifyListeners();
  }

 
}
