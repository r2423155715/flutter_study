import 'package:demo/page/login/login.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './routerhandler.dart';

class Routes {
  static String root = '/';
  static String indexPage = '/index';
  static String loginPage = '/login';

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
  }
}
