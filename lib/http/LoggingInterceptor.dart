import 'package:dio/dio.dart';
class LoggingInterceptor extends Interceptor {
  DateTime startTime;
  DateTime endTime;

  @override
  onRequest(RequestOptions options) {
    startTime = DateTime.now();
    print("Request----------Start----------");
    if (options.queryParameters.isEmpty) {
      print("RequestUrl: " + options.baseUrl + options.path);
    } else {
      print("RequestUrl: " +
          options.baseUrl +
          options.path +
          "?" +
          Transformer.urlEncodeMap(options.queryParameters));
    }
    print("RequestMethod: " + options.method);
    print("RequestHeaders:" + options.headers.toString());
    print("RequestContentType: ${options.contentType}");
    print("RequestData: ${options.data.toString()}");
    return super.onRequest(options);
  }

  @override
  onResponse(Response response) {
    endTime = DateTime.now();
    int duration = endTime.difference(startTime).inMilliseconds;
    print("Request ResponseCode: ${response.statusCode}");
    // 输出结果
    print("Request 结果："+response.data.toString());
    print("Request----------End: $duration 毫秒----------");
    return super.onResponse(response);
  }

  @override
  onError(DioError err) {
    print("Request----------Error-----------");
    return super.onError(err);
  }
}