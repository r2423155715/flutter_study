import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:install_plugin/install_plugin.dart';
import 'package:path_provider/path_provider.dart';

class UpdateDialog extends StatefulWidget {
  final String version;
  final String notes;
  final String fileUrl;
  final String packageName;

  const UpdateDialog(
      {Key key, this.version, this.notes, this.fileUrl, this.packageName})
      : super(key: key);

  @override
  _UpdateDialogState createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  String btnText = '立即更新';

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Color.fromRGBO(0, 0, 0, 0.2),
      child: new InkWell(
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          Navigator.pop(context);
        },
        child: new Container(
          height: double.infinity,
          width: double.infinity,
          child: new Center(
            child: new InkWell(
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {},
              child: new Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Image.asset(
                      "image/upload.png",
                    ),
                    new Flexible(
                      child: new Container(
                        color: Colors.white,
                        child: new SingleChildScrollView(
                          child: new Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Row(
                                children: <Widget>[
                                  new Expanded(
                                    child: new Container(
                                      color: Colors.white,
                                      child: new Text(
                                        "发现新版本(V${widget?.version})",
                                        textAlign: TextAlign.center,
                                        style: new TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              new Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 15),
                                child: new Text(
                                  "${widget?.notes}",
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      width: double.infinity,
                      height: 48,
                      child: new FlatButton(
                        onPressed: () {
                          if ("立即更新" == btnText) {
                            download();
                          }
                        },
                        child: new Text(
                          "$btnText",
                          style: new TextStyle(color: Colors.white),
                        ),
                        color: Theme.of(context).primaryColor,
                        shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(1),
                            topRight: Radius.circular(1),
                            bottomRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void download() async {
    //获取根目录地址
    final dir = await getExternalStorageDirectory();
    //自定义目录路径(可多级)
    String _apkFilePath = dir.path + '/apk.apk';
    Dio dio = new Dio();
    try {
      Response response = await dio.download(
        widget?.fileUrl,
        _apkFilePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            this.btnText = (received / total * 100).toStringAsFixed(0) + "%";
            print("文件下载1：" + btnText);

            if (mounted) {
              setState(() {});
            }
            if (received == total) {
              if (mounted) {
                Navigator.pop(context);
              }
              try {
//                InstallPlugin.installApk(_apkFilePath,"com.astgo.xinxinlove")
//                    .then((result) {
//                  print('install apk $result');
//                }).catchError((error) {
//                  print('install apk error: $error');
//                });
              } on PlatformException catch (_) {}
              debugPrint("文件路径：" + _apkFilePath);
              InstallPlugin.installApk(
                      _apkFilePath, 'com.xiaoanweishi.schoolapp')
                  .then((result) {
                print('install apk $result');
              }).catchError((error) {
                print('install apk error: $error');
              });
            }
          }
        },
      );
    } catch (e) {
      Fluttertoast.showToast(msg: "更新失败！");
      Navigator.pop(context);
    }
  }
}
