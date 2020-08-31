import 'dart:convert';
import 'dart:io';

import 'package:demo/config/eventbus1.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:demo/config/eventbus1.dart';

import 'LoadingView.dart';
import 'LoggingInterceptor.dart';
import 'TokenInterceptor.dart';

Map<String, dynamic> parseData(String data) {
  return json.decode(data);
}

class DioUtils {
  static final DioUtils instance = DioUtils._internal();

  factory DioUtils() => instance;
  Dio dio;

  DioUtils._internal() {
    print("DioUtils_internal()");
    if (dio == null) {
      print("DioUtils_options  new");
      BaseOptions options = BaseOptions(
        // baseUrl: "",
        contentType: Headers.formUrlEncodedContentType,
        responseType: ResponseType.json,
        receiveDataWhenStatusError: true,
        connectTimeout: 15000,
        receiveTimeout: 15000,
      );
      dio = Dio(options);

      /// Fiddler抓包代理配置 https://www.jianshu.com/p/d831b1f7c45b
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
//      client.findProxy = (uri) {
//        //proxy all request to localhost:8888
//        return "PROXY 192.168.0.245:8888";
//      };
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
      dio.interceptors.add(new TokenInterceptor());
      dio.interceptors.add(new LoggingInterceptor());
//      dio.interceptors.add(DioCacheManager(CacheConfig(
//              baseUrl: HttpUrls.ip,
//              defaultMaxAge: new Duration(days: 0),
//              defaultMaxStale: new Duration(days: 30)))
//          .interceptor);
    }
  }

  _requestHttp(
    String url,
    Function onSucceed,
    String method, {
    var params,
    Options options,
    BuildContext context,
    Function onFailure,
    bool showError: true,
  }) async {
    if (context != null) {
      LoadingUtils.showLoading(context);
    }
    try {
      Response response;
      if (method == "GET") {
        response =
            await dio.get(url, queryParameters: params, options: options);
      } else if (method == "POST") {
        response = await dio.post(url, data: params, options: options);
      }
      LoadingUtils.dismiss();

      if (response.data['code'] != 1) {
        print("提示了");
        if (response.data['code'] == 102 ||
            response.data['code'] == 100) {
          if(response.data['code'] == 102 ){
            Fluttertoast.showToast(msg: response.data['msg']);
          }
          SpUtil.clear();
          print("我现在的调走了");
          eventBus.fire({"colorStr":"gologin"});
        } else {
          Fluttertoast.showToast(msg: response.data['msg']);
        }
        if (onFailure != null) {
          print("走了走了");
          onFailure(response.data['code'], response.data['msg']);
        }
      } else {
        if (onSucceed != null) {
          onSucceed(response.data['data']);
        }
      }
    } catch (e) {
      //if(error is DioError)
      print(e.toString());
      onFailure("10000", e.toString());
    }
//      if (response.data == null) {
//        if (showError) {
//          print("数据异常");
//        }
//        if (onFailure != null) {
//          //print("请求结果：" + response?.data?.toString());
//          onFailure(10001, "数据异常");
//        }
//        return;
//      }
//      //print("请求结果：" + response?.data?.toString());
//      // Map<String, dynamic> result = json.decode(response.data.toString());
////      Map<String, dynamic> result =
////          await compute(parseData, response?.data?.toString());
//      Map<String, dynamic> result = response?.data;
//      if (result == null) {
//        if (showError) {
//          print("数据异常");
//        }
//        if (onFailure != null) {
//          onFailure(10001, "数据异常");
//        }
//        //print("请求结果：" + response?.data?.toString());
//        return;
//      }
////      请求错误
//      if (result['code'] != 1) {
//        if (showError) {
//          print(result['msg']);
//        }
//        if (onFailure != null) {
//          onFailure(result['code'], result['msg']);
//        }
//        return;
//      }
//      //您的账号已在其他设备上登录（返回登录界面）
//      if (result['code'] == 102) {
//        if (showError) {
//          print(result['msg'], );
//        }
//        DioUtils.instance.dio.lock();
//        DioUtils.instance.dio.clear();
//        DioUtils.instance.dio.unlock();
////        eventBus.fire(new EventBusTag(tag: 1));
//        return;
//      }
//
//      if (onSucceed != null) {
//        onSucceed(result['data']);
//      }
//    } catch (error) {
//      LoadingUtils.dismiss();
//      if (showError) {
//        if (error is DioError) {
//          if (error.type == DioErrorType.DEFAULT ||
//              error.type == DioErrorType.RESPONSE) {
//            dynamic e = error.error;
//            if (e is SocketException) {
//              if (e.osError.errorCode == 113) {
//                print('服务器开小差了');
//              } else {
//                print('网络开小差了');
//              }
//            } else if (e is HttpException) {
//              print('服务器开小差了');
//            } else {
//              print('网络开小差了');
//            }
//          } else if (error.type == DioErrorType.CONNECT_TIMEOUT ||
//              error.type == DioErrorType.SEND_TIMEOUT ||
//              error.type == DioErrorType.RECEIVE_TIMEOUT) {
//            print('网络开小差了');
//          } else if (error.type == DioErrorType.CANCEL) {
//            print('取消请求');
//          } else {
//            print('${error.toString()}');
//          }
//        } else {
//          print('${error.toString()}');
//        }
//      }
//
//      onFailure(10001, error.toString());
//      debugPrint("请求结果异常：" + error.toString());
//    }
  }

  //post请求
  post(
    String url, {
    var data,
    BuildContext context,
    Options options,
    Function onSucceed,
    Function onFailure,
    bool showError: true,
  }) async {
    return await _requestHttp(
      url,
      onSucceed,
      "POST",
      params: data,
      options: options,
      context: context,
      onFailure: onFailure,
      showError: showError,
    );
  }

  //get请求
  get(
    String url, {
    var data,
    BuildContext context, //显示加载框
    Options options, //
    Function onSucceed,
    Function onFailure,
    bool showError: true,
  }) async {
    return await _requestHttp(url, onSucceed, "GET",
        params: data,
        options: options,
        context: context,
        onFailure: onFailure,
        showError: showError);
  }
}
