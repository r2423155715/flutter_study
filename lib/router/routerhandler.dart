import 'dart:convert';

import 'package:demo/page/onecate/video.dart';
import 'package:demo/page/onecate/video1.dart';
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
//视频播放页
Handler videoHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("页面传递参数${params}");
      return VideoPage();
    });
//视频播放页
Handler video1Handler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("页面传递参数${params}");
      return Video1Page();
    });
