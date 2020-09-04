import 'package:demo/page/login/login.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './routerhandler.dart';

class Routes {
  static String root = '/';
  static String indexPage = '/index';
  static String loginPage = '/login';
  static String videoPage = '/video';
  static String video1Page = '/video1';
  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("页面找不到了");
      return null;
    });

    //   首页
    router.define(indexPage, handler: tabHandler);

//  登录
    router.define(loginPage, handler: loginHandler);
    //  视频也
    router.define(videoPage, handler: videoHandler);
    //  视频也
    router.define(video1Page, handler: video1Handler);
  }
}
