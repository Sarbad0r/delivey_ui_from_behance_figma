import 'package:delivery_food_app_from_behance1/widgets/side_bar.dart';
import 'package:flutter/material.dart';

class AllOrders extends StatefulWidget {
  AllOrders({Key? key}) : super(key: key);

  @override
  State<AllOrders> createState() => _AllOrdersState();
}

var _scaffoldState = GlobalKey<ScaffoldState>();

class _AllOrdersState extends State<AllOrders> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        drawer: SideBar(),
        key: _scaffoldState,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
              onPressed: () {
                _scaffoldState.currentState?.openDrawer();
              },
              icon: Icon(Icons.menu)),
          elevation: 0,
          title: Text("Все заказы"),
        ),
      ),
    );
  }
}
