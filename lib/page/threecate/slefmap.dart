import 'dart:async';

import 'package:amap_all_fluttify/amap_all_fluttify.dart';
import 'package:amap_location/amap_location.dart';
import 'package:flutter/material.dart';
import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with SingleTickerProviderStateMixin {
//  倒计时
  Timer timer;

//  自定义坐标
  List<MarkerOption> allList = [];

  //----属性----
  AMapLocation loc;

  //搜索出来之后选择的点
  Marker _markerSeached;

  //地图控制器
  AmapController _amapController;

  //所在城市
  String city;

//搜索框文字控制器
  TextEditingController _serachController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _amapController.clear();
    timer.cancel();
    super.dispose();
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
          zoomLevel: 17,
          onMapClicked: (LatLng latLng) async {
            print("我点击了===》${latLng.toString()}");
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
              city = loc.city;
              _amapController.showMyLocation(MyLocationOption(show: true));
              setState(() {});
              timer = new Timer(new Duration(seconds: 4), () {
                // 只在倒计时结束时回调
                print("倒计时结束");
                _amapController.addMarker(MarkerOption(
                  title: "啊壮成人用品",
                  visible: true,
                  latLng: LatLng(34.777713078729995, 113.71055542608839),
                  widget: Container(
                    width: 30,
                    height: 30,
                    color: Colors.transparent,
                    child: Image.asset(
                      'image/nurse.png',
                      fit: BoxFit.fill,
                    ),
                  ),
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
              print('xianzaibili====${await _amapController.getZoomLevel()}');
              loc = await AMapLocationClient.getLocation(true);
              _amapController
                  .setCenterCoordinate(LatLng(loc.latitude, loc.longitude))
                  .then((value) {
                print("中心店设置完成");
                _setzommLevel();
              });

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
        ),
        Positioned(
          right: 6,
          bottom: 135,
          child: InkWell(
            onTap: () async {
              if (_markerSeached != null)
                _amapController.clearMarkers([_markerSeached]);
            },
            child: Container(
              width: 40,
              height: 40,
              color: Colors.blue,
              alignment: Alignment.center,
              child: Text(
                '清楚',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ),
//        搜索
        Positioned(
          child: Container(
            margin: EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            height: 46,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width - 20 - 80,
                  child: TextField(
                    controller: _serachController,
                    decoration: InputDecoration(border: InputBorder.none),
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(10) //限制长度
                    ],
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.search), onPressed: _openModalBottomSheet)
              ],
            ),
          ),
        )
      ],
    ));
  }

//  键盘
  Future _openModalBottomSheet() async {
    //收起键盘
    FocusScope.of(context).requestFocus(FocusNode());
    print("我输入的文本123123===》${_serachController}");
    print("我输入的文本===》${_serachController.text}");
    final poList =
        await AmapSearch.searchKeyword(_serachController.text, city: city);
    print("搜索的结果===>${poList}");
    List<Map> msgList = [];
    for (var item in poList) {
      msgList.add({
        'title': await item.title,
        'address': await item.adName + await item.address,
        'position': await item.latLng,
      });
    }
//弹出底部对话框并等待选择
    final options = await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return msgList.length > 0
              ? ListView.builder(
                  itemCount: msgList.length ?? 0,
                  itemBuilder: (item, i) {
                    return ListTile(
                      title: Text(msgList[i]['title']),
                      subtitle: Text(msgList[i]['address']),
                      onTap: () {
                        Navigator.pop(context, msgList[i]);
                      },
                    );
                  },
                )
              : Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(40),
                  child: Text('暂无数据'));
        });
//    选择列表之后
    if (options != null) {
      print('选择的options=?????${options}');
      LatLng lng = options['position'];
      _amapController.setCenterCoordinate(LatLng(lng.latitude, lng.longitude));
      if (_markerSeached != null) {
        _markerSeached.remove();
      }
      print("选择的经纬度====>${lng.latitude}====${lng.longitude}");
      Timer(new Duration(seconds: 1), () async {
        _markerSeached = await _amapController.addMarker(MarkerOption(
            latLng: LatLng(lng.latitude, lng.longitude),
            visible: true,
            widget: Container(
              width: 20,
              height: 20,
              color: Colors.blue,
            )));
      });
    }
  }


   _setzommLevel(){
    Future.delayed(Duration(seconds: 1)).then((e) {
      _amapController.setZoomLevel(17).then((value) {
        print("bilihuifu");
      });
    });
  }
}
