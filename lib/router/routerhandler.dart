import 'dart:convert';

import 'package:demo/page/tabbar.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:demo/page/login/login.dart';
//登录页
Handler loginHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  print("页面传递参数${params}");
  return LoginPage();
});
//首页
Handler tabHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("页面传递参数${params}");
      return IndexPage();
    });
