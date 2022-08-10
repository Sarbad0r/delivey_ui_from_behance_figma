import 'package:flutter/material.dart';

import '../utils/dimension.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.size30 - 3,
      height: Dimensions.size18,
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
                width: Dimensions.size10 - 1,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.all(Radius.circular(Dimensions.size100)))),
          ),
          Expanded(
              child: Container(
            color: Colors.black,
          )),
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.all(Radius.circular(Dimensions.size100)))),
          ),
          Expanded(
              child: Container(
            width: double.maxFinite,
            color: Colors.black,
          )),
          Expanded(
            child: Container(
              width: Dimensions.size18,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.size100))),
            ),
          ),
        ],
      ),
    );
  }
}
