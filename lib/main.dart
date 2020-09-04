import 'package:amap_location/amap_location.dart';
import 'package:demo/page/lanch.dart';
import 'package:demo/page/tabbar.dart';
import 'package:demo/public/db/data_helper.dart';
import 'package:demo/public/db/data_sqlite.dart';
import 'package:demo/router/application.dart';
import 'package:demo/router/routers.dart';
import 'package:fluro/fluro.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'config/providermodel.dart';
import 'package:amap_map_fluttify/amap_map_fluttify.dart';

final JPush jpush = new JPush();

void main() async {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Counter2()),
        ],
        child: MyApp(),
      )
  );
  await DatabaseSqliteHelper.getInstance().then((value) {
//    print('数据库加载完===${value.getTables()}');
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jpush.setup(
      appKey: "b79e9fbb2198dd16b92eff88",
      channel: "flutter_channel",
      production: false,
      debug: true, //是否打印debug日志
    );
    jpush.getRegistrationID().then((value) {
      print("rid=>" + value);
    });
    _getmsg();
  }

  // 接收通知回调方法。
  void _getmsg() {
    jpush.addEventHandler(
//      接收通知消息
      onReceiveMessage: (Map<String, dynamic> message) async {
        print("监听的信息==》${message}");
      }, // 点击通知回调方法。        
      onOpenNotification: (Map <String, dynamic> message) async {
        print("点击推送==》${message}");
        print("内容==>${message['extras']['cn.jpush.android.ALERT']}");
        print("title==>${message['title']}");
      },
//        自定义消息
      onReceiveNotification: (Map <String, dynamic> message) async {
        print("自定义消息==》${message}");
        print("内容==>${message['extras']['cn.jpush.android.ALERT']}");
        print("title==>${message['title']}");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Map token1 = SpUtil.getObject('token');
    print("token=>${token1}");
    final router = Router(); //路由初始化
    Routes.configureRoutes(router);
    Application.router = router;
    return MaterialApp(
      onGenerateRoute: Application.router.generator,
      //路由静态化
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: Colors.blue),
      home: LaunchPage(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalEasyRefreshLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: [Locale('zh', 'CN')],
    );
  }
}
