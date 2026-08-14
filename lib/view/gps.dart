import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart' as latlng; // <<<<<<<<<<<

class Gps extends StatefulWidget {
  const Gps({super.key});

  @override
  State<Gps> createState() => _GpsState();
}

class _GpsState extends State<Gps> {

  // Property
  late Position currentPosition;      // GPS 신호
  late int kindChoice;                // segmented Control 의 번호 
  late double latData;                // 위도 정보
  late double longData;               // 경도 정보
  late MapController mapController;   // 지도 제어
  late bool canRun;                   // GPS 신호를 받았냐?
  late List location;                 // 지도에 글씨 쓰기

  // Segment Widget Data
  Map<int, Widget> segmentWidgets = {
    0 : SizedBox(
      child: Text(
        '현위치',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
        ),
      ),
    ),
    1 : SizedBox(
      child: Text(
        '강남 세브란스병원',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
        ),
      ),
    ),
    2 : SizedBox(
      child: Text(
        '강남 차병원',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
        ),
      ),
    ),
  };

  @override
  void initState() {
    super.initState();
    kindChoice = 0;
    mapController = MapController();
    canRun = false;
    location = [
      '현위치',
      '강남 세브란스병원',
      '강남 차병원'
    ];
    checkLocationPermission();
  }

  void checkLocationPermission()async{
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
    }

    if(permission == LocationPermission.deniedForever){
      return;
    }

    if(permission==LocationPermission.whileInUse || permission==LocationPermission.always){
      getCurrentLocation();
    }
  }

  void getCurrentLocation()async{
    Position position = await Geolocator.getCurrentPosition();
    currentPosition = position;
    canRun=true;
    latData = currentPosition.latitude;
    longData = currentPosition.longitude;
    print('-------> lat : $latData, long : $longData');
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Center(
          child: Column(
            children: [
              Text('GPS & Map'),
              CupertinoSegmentedControl(
                groupValue: kindChoice,
                children: segmentWidgets, 
                onValueChanged: (value) {
                  kindChoice = value;
                  if(kindChoice== 0){ // 현위치
                    getCurrentLocation();
                    latData = currentPosition.latitude;
                    longData = currentPosition.longitude;
                    mapController.move(
                      latlng.LatLng(latData, longData), 
                      17.0,
                    );
                  }else if(kindChoice==1){ // 둘리 뮤지엄
                    latData = 37.492566;
                    longData = 127.046499;
                    mapController.move(
                      latlng.LatLng(latData, longData), 
                      17.0,
                    );
                  }else{ // 서대문형무소역사관
                    latData = 37.506842;
                    longData = 127.034721;
                    mapController.move(
                      latlng.LatLng(latData, longData), 
                      17.0,
                    );
                  }
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
      body: canRun
      ? flutterMap()
      : Center(child: CircularProgressIndicator(),)
      ,
    );
  }

  // Widgets
  Widget flutterMap(){
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: latlng.LatLng(latData,longData),
        initialZoom: 17.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.mega.gpsmapapp',
        ),
        MarkerLayer(
          markers: [
            Marker(
              width: 80,
              height: 80,
              point: latlng.LatLng(latData,longData), 
              child: Column(
                children: [
                  SizedBox(
                    child: Text(
                      location[kindChoice],
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.pin_drop,
                    size: 50,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}