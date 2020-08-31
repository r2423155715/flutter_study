import 'package:amap_location/amap_location.dart';
import 'package:amap_location/amap_location_option.dart';
import 'package:demo/page/threecate/map.dart';
import 'package:demo/page/threecate/slefmap.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ThreeCatePage extends StatefulWidget {
  @override
  _ThreeCatePageState createState() => _ThreeCatePageState();
}

class _ThreeCatePageState extends State<ThreeCatePage> {
  AMapLocation loc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第三个'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
//            FlatButton(
//              onPressed: (){
//                _getlocation();
//              },
//              child: Text('获取位置'),
//            ),
//            Expanded(
//              child: Center(child: MapChoicePoint((point) {
//                debugPrint(point.toString());
//              }),
//              ),
//            ),
            Expanded(child: MapPage())
          ],
        ),
      ),
    );
  }


//  =======方法获取位置
  _getlocation()async{
    var status = await Permission.location.status;
    Map<Permission, PermissionStatus> statuses =
    await [Permission.location].request();
    print('77${status}');
    if (!statuses[Permission.location].isGranted) {
      print("没权限");
      openAppSettings();
    } else {
      await AMapLocationClient.startup(new AMapLocationOption(
          desiredAccuracy:
          CLLocationAccuracy.kCLLocationAccuracyHundredMeters));

      loc = await AMapLocationClient.getLocation(true);
      setState(() {});
      print(
          "定位成功: \n时间${loc.timestamp}\n经纬度:${loc.latitude} ${loc.longitude}\n 地址:${loc.formattedAddress}区（县）:${loc.district} 城市:${loc.city} 省:${loc.province}");
      print("我获取定位结束");
    }
  }
}
