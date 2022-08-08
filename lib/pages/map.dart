import 'dart:async';

import 'package:delivery_food_app_from_behance1/utils/dimension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class ReverseSearchPage extends StatefulWidget {
  dynamic getParentState;
  ReverseSearchPage({
    Key? key,
    this.getParentState,
  }) : super(key: key);

  @override
  State<ReverseSearchPage> createState() => _ReverseSearchPageState();
}

class _ReverseSearchPageState extends State<ReverseSearchPage> {
  String street = '';
  final TextEditingController queryController = TextEditingController();
  late YandexMapController controller;
  late final List<MapObject> mapObjects = [
    PlacemarkMapObject(
      mapId: cameraMapObjectId,
      point: const Point(latitude: 38.53575, longitude: 68.77905),
      icon: PlacemarkIcon.single(PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage('assets/map/place.png'),
          scale: 1.75)),
      opacity: 0.5,
    )
  ];

  final MapObjectId cameraMapObjectId = MapObjectId('camera_placemark');
  @override
  Widget build(BuildContext context) {
    final mapHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            if (street.isNotEmpty)
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$street",
                      style: TextStyle(fontSize: Dimensions.size14 - 2),
                    ),
                    IconButton(
                        onPressed: () {
                          widget.getParentState(street);
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          FontAwesomeIcons.locationDot,
                          size: Dimensions.size20,
                        ))
                  ],
                ),
              )
          ],
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: _search,
        child: Icon(
          FontAwesomeIcons.locationDot,
          color: Colors.white,
        ),
      ),
      body: Stack(children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: mapHeight,
          child: Stack(
            fit: StackFit.expand,
            children: [
              YandexMap(
                mapObjects: mapObjects,
                onCameraPositionChanged: (CameraPosition cameraPosition,
                    CameraUpdateReason _, bool __) async {
                  final placemarkMapObject = mapObjects
                          .firstWhere((el) => el.mapId == cameraMapObjectId)
                      as PlacemarkMapObject;

                  setState(() {
                    mapObjects[mapObjects.indexOf(placemarkMapObject)] =
                        placemarkMapObject.copyWith(
                            point: cameraPosition.target);
                  });
                },
                onMapCreated: (YandexMapController yandexMapController) async {
                  final placemarkMapObject = mapObjects
                          .firstWhere((el) => el.mapId == cameraMapObjectId)
                      as PlacemarkMapObject;

                  controller = yandexMapController;

                  await controller.moveCamera(CameraUpdate.newCameraPosition(
                      CameraPosition(
                          target: placemarkMapObject.point, zoom: 12)));
                },
              )
            ],
          ),
        ),
      ]),
    );
  }

  void _search() async {
    EasyLoading.show(status: "Загрузка");
    final cameraPosition = await controller.getCameraPosition();

    print('Point: ${cameraPosition.target}, Zoom: ${cameraPosition.zoom}');

    var resultWithSession = YandexSearch.searchByPoint(
      point: cameraPosition.target,
      zoom: cameraPosition.zoom.toInt(),
      searchOptions: const SearchOptions(
        searchType: SearchType.geo,
        geometry: false,
      ),
    );

    SearchSessionResult result = await resultWithSession.result;
    if (result.error != null) {
      EasyLoading.dismiss();
      // showSimpleNotification(Text("Проблемы с подключением"),
      //     background: Colors.redAccent);
      FocusManager.instance.primaryFocus?.unfocus();

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Проблемы с подключением"),
          backgroundColor: Colors.redAccent));
      // EasyLoading.showError("SOMETHING_WENT_WRONG");
      return;
    }

    EasyLoading.dismiss();
    print('Page ${result.page}: ${result.items}');
    print('STREET ${street}');
    AlertDialog newAlerDialog = AlertDialog(
      title: Text("Проверка адреса"),
      content: Text(result.items![0].name.toString()),
      actions: [
        TextButton(
            onPressed: () {
              setState(() {
                street = result.items![0].name.toString();
              });
              Navigator.pop(context);
            },
            child: Text("Да")),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Нет"))
      ],
    );
    showDialog(context: context, builder: (context) => newAlerDialog);
  }
}
