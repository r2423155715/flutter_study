import 'dart:async';

import 'package:amap_all_fluttify/amap_all_fluttify.dart';
import 'package:amap_location/amap_location.dart';
import 'package:flutter/material.dart';
import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:permission_handler/permission_handler.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
//  自定义坐标
  List<MarkerOption> allList = [];

  //----属性----
  AMapLocation loc;

  //地图控制器
  AmapController _amapController;

  //所在城市
  String city;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: <Widget>[
        AmapView(
          // 地图类型 (可选)
          mapType: MapType.Bus,
          // 是否显示缩放控件 (可选)
          showZoomControl: true,
          // 是否显示指南针控件 (可选)
          showCompass: true,
          // 是否显示比例尺控件 (可选)
          showScaleControl: true,
          // 是否使能缩放手势 (可选)
          zoomGesturesEnabled: true,
          // 是否使能滚动手势 (可选)
          scrollGesturesEnabled: true,
          // 是否使能旋转手势 (可选)
          rotateGestureEnabled: true,
          // 是否使能倾斜手势 (可选)
          tiltGestureEnabled: true,
          // 缩放级别 (可选)
          zoomLevel: 16,
          onMapClicked: (LatLng latLng) async {
            print("我点击了===》${latLng}");
          },
          onMapCreated: (controller) async {
            print("创建完毕");
            _amapController = controller;
            Map<Permission, PermissionStatus> statuses =
                await [Permission.location].request();
            if (statuses[Permission.location].isGranted) {
              print("有权限");
              await AMapLocationClient.startup(new AMapLocationOption(
                  desiredAccuracy:
                      CLLocationAccuracy.kCLLocationAccuracyHundredMeters));
              loc = await AMapLocationClient.getLocation(true);

              _amapController.showMyLocation(MyLocationOption(show: true));
              setState(() {});
              Timer timer = new Timer(new Duration(seconds: 10), () {
                // 只在倒计时结束时回调
                print("倒计时结束");
                _amapController.addMarker(MarkerOption(
                  title: "啊壮成人用品",
                  visible: true,
                  latLng: LatLng(34.777713078729995,113.71055542608839),
//                  widget: Container(
//                    width: 30,
//                    height: 30,
//                    color: Colors.blue,
//                  ),
                  iconProvider: AssetImage('image/empty.png')
                ));
              });
            }
          },
        ),
        Positioned(
          right: 6,
          bottom: 90,
          child: InkWell(
            onTap: () async {
              loc = await AMapLocationClient.getLocation(true);
              _amapController
                  .setCenterCoordinate(LatLng(loc.latitude, loc.longitude));
            },
            child: Container(
              width: 40,
              height: 40,
              color: Colors.blue,
              alignment: Alignment.center,
              child: Text(
                '定位',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
