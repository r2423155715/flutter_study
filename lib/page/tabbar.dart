import 'package:demo/page/add/index.dart';
import 'package:demo/page/fourcate/index.dart';
import 'package:demo/page/login/login.dart';
import 'package:demo/page/onecate/index.dart';
import 'package:demo/page/threecate/index.dart';
import 'package:demo/page/twocate/index.dart';
import 'package:demo/router/application.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int index = 0;
  List<Widget> list = [
    OneCatePage(),
    TwoCatePage(),
    AddPage(),
    ThreeCatePage(),
    FourCatePage()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getpwoer();
  }

  void getpwoer() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      Permission.camera.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: list[index],
        floatingActionButton: FloatingActionButton(
//          highlightElevation :
//          (MediaQuery.of(context).viewInsets.bottom != 0 && index == 3)
//              ? 0
//              : 12.0,
//          elevation:
//              (MediaQuery.of(context).viewInsets.bottom != 0 && index == 3)
//                  ? 0
//                  : 6.0,
          backgroundColor:Colors.blue,
//              (MediaQuery.of(context).viewInsets.bottom != 0 && index == 3)
//                  ? Colors.transparent
//                  : Colors.blue,
          onPressed: () {
            setState(() {
              index = 2;
            });
          },
          tooltip: "new page",
          child: Icon(
            Icons.add,
            color:Colors.white
//            (MediaQuery.of(context).viewInsets.bottom != 0 && index == 3)
//                ? Colors.transparent
//                : Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Theme(
          data: ThemeData(
            brightness: Brightness.light,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text('Home')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), title: Text('Find')),
              BottomNavigationBarItem(icon: Icon(null), title: Text('Cart')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.photo_filter), title: Text('Zone')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.face), title: Text('Ucenter')),
            ],
            currentIndex: index,
            onTap: (value) {
              print("我点击了tabbar===>>${value}");
              setState(() {
                index = value;
              });
            },
          ),
        ),
      ),
    );
  }
}
