import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:demo/http/HttpUrls.dart';
import 'package:demo/http/LoadingView.dart';

Future uploads(context,String filePath, String fileName) async {

  LoadingUtils.showLoading(context);
  print("上传文件：" + filePath);
  Dio dio = new Dio(BaseOptions(responseType: ResponseType.json));

//  Uint8List afterUint8List = await FlutterImageCompress.compressWithFile(
//    filePath,
//    minWidth: 540,
//    minHeight: 540,
//    quality: 80,
//    rotate: 0,
//  );
//  debugPrint("压缩后：" + (afterUint8List.length / 1024).toString());
  var formData = FormData.fromMap({
    "file": [
        await MultipartFile.fromFile(filePath, filename: fileName),
//      MultipartFile.fromBytes(afterUint8List, filename: fileName),
    ]
  });
//  var formData={
//    "file":filePath
//  };
  print('我传的数据${formData.toString()}');
  print("我的token=${SpUtil.getObject('token')['token']}");
  try {
    Response response = await dio.post(
      HttpUrls.upload,
      data: formData,
      options: Options(headers: {"token":SpUtil.getObject('token')['token']}),
      onSendProgress: (int sent, int total) {
        print("$sent $total"); //send是上传的大小 total是总文件大小
      },
    );
    LoadingUtils.dismiss();
    print("结果：" + response.data.toString());
    if (response.data == null) {
      Fluttertoast.showToast(msg: "数据异常");
      return null;
    }
    if (response.data['code'] != 1) {
      Fluttertoast.showToast(msg: '上传失败');
      return null;
    }
//    UpLoadFileModel upLoadFileModel =
//    UpLoadFileModel.fromJson(response.data['data']);
  return response.data['data'];
  } catch (e) {
    LoadingUtils.dismiss();
    print("上传失败:" + e.toString());
  Fluttertoast.showToast(msg: "上传失败！");
  }
}