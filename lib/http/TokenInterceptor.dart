import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:demo/config/eventbus1.dart';
import 'package:demo/page/onecate/index.dart';
import 'package:demo/page/login/login.dart';
import 'package:demo/router/application.dart';

//import 'package:oktoast/oktoast.dart';
//import 'package:xinxinlove/app/AppContact.dart';
//import 'package:xinxinlove/common/http/HttpUrls.dart';
//import 'package:xinxinlove/common/model/EventBusTag.dart';
//import 'package:xinxinlove/common/utils/DateUtils.dart';
//import 'package:xinxinlove/common/utils/SpUtils.dart';
//import 'package:xinxinlove/main.dart';
//import 'package:xinxinlove/pages/login/model/LoginModel.dart';

import 'DioUtils.dart';
import 'HttpUrls.dart';

class TokenInterceptor extends Interceptor {
  @override
  Future onRequest(RequestOptions options) async {
    Map tokenmsg = SpUtil.getObject("token");
    bool loginState = false;
    print('tokenmsg=${tokenmsg}');
    if (tokenmsg != null) {
      loginState = true;
    }
//        SpUtils.getBool(AppContact.loginState, defValue: false); //是否登录
    print("有无token${tokenmsg}");
    if (loginState) {
      DioUtils.instance.dio.lock();
      int loginExpiration = tokenmsg['expiration'];
//          SpUtils.getInt(AppContact.expiration, defValue: 0); //token过期时间
      int currentTime =
          (DateTime.now().millisecondsSinceEpoch) ~/ 1000; //获取当前时间戳10位
//      print("token过期时间：" + DateUtils.formatDateMs(loginExpiration * 1000));
      if (currentTime >= loginExpiration) {
        print("开始刷新token");
        try {
          BaseOptions _baseOptions = BaseOptions(
            contentType: Headers.formUrlEncodedContentType,
            responseType: ResponseType.json,
            receiveDataWhenStatusError: true,
            connectTimeout: 15000,
            receiveTimeout: 15000,
            validateStatus: (status) {
              // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
              return true;
            },
            // baseUrl: Api.base_url,
          );
          Dio dio = new Dio(_baseOptions);
          var data = {"refertoken": tokenmsg['refertoken']};
          print("刷新的token参数:" + data.toString());
          var response = await dio.post(
            HttpUrls.refertoken,
            data: data,
          );
          print("response=${response}");
          print("刷新token结果：" + response.toString());
          print("刷新token结果类型：" + response.data.runtimeType.toString());
          var result =  Map<String, dynamic>.from(response.data);
          print('result=${result}');
          if (result['code'] == 1) {
            SpUtil.putObject("token", result['data']);
            tokenmsg = SpUtil.getObject("token");
//            LoginModel loginModel = LoginModel.fromJson(result['data']);
//            SpUtils.putString(AppContact.token, loginModel.token);
//            SpUtils.putString(AppContact.refertoken, loginModel.refertoken);
//            SpUtils.putInt(AppContact.expiration, loginModel.expiration);
            print("刷新token成功");
            DioUtils.instance.dio.unlock();
          } else {
            DioUtils.instance.dio.clear();
            DioUtils.instance.dio.unlock();
            print("重新登录了1");
            //todo 重新登录
            eventBus.fire({'colorStr':"gologin"});
//            eventBus.fire(new EventBusTag(tag: 1));
          }
        } catch (e) {
          DioUtils.instance.dio.clear();
          DioUtils.instance.dio.unlock();
          print("重新登录了2==");
//          showToast("重新登录了2");
          //todo 重新登录
//          SpUtils.putBool(AppContact.loginState, false);
         eventBus.fire({"colorStr":"gologin"});
          //eventBus.fire('132');
        }
      } else {
        DioUtils.instance.dio.unlock();
      }
      options.headers["token"] = tokenmsg['token'];
//          SpUtils.getString(AppContact.token); //请求添加token
    }
    return super.onRequest(options);
  }

//  @override
//  Future onResponse(Response response) {
//    // TODO: implement onResponse
//    return super.onResponse(response);
//  }
}
