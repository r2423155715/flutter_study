import 'package:demo/router/application.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_record/flutter_plugin_record.dart';
import 'package:flutter_plugin_record/voice_widget.dart';

class FourCatePage extends StatefulWidget {
  @override
  _FourCatePageState createState() => _FourCatePageState();
}

class _FourCatePageState extends State<FourCatePage> {
  //实例化对象
  FlutterPluginRecord recordPlugin = new FlutterPluginRecord();
  Map music={
    'path':'',
    'time':''
  };
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    初始化
    recordPlugin.init();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    recordPlugin.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第四个'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            FlatButton(
              color: Colors.red,
              onPressed: () {
                Application.router.navigateTo(context, '/login');
              },
              child: Text('登录'),
            ),
            VoiceWidget(
              startRecord: () {
                print('开始录制=====');
              },
              stopRecord: (e,e1) {
                print('结束录制=====$e=====$e1');
                setState(() {
                  music['path']=e;
                  music['time']=e1;
                });
              },
            ),
            Text('path=${music["path"]},time=${music['time']}'),
            FlatButton(
              color: Colors.red,
              onPressed: (){
                recordPlugin.play();
              },
              child: Text('播放'),
            )
          ],
        ),
      ),
    );
  }
}
