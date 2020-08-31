//import 'package:flutter/cupertino.dart';
//import 'package:permission_handler/permission_handler.dart';
//import 'package:yxk_app/constant/functions.dart';
//
///// 权限管理工具类
//class PermissionUtils {
//  /// 检测相关权限是否已经打开(根据已有状态值)
//  static bool checkPermissionsByStatus(List<PermissionStatus> lists) {
//    bool result = true;
//
//    for (PermissionStatus permissionStatus in lists) {
//      if (permissionStatus != PermissionStatus.granted) {
//        result = false;
//        break;
//      }
//    }
//
//    return result;
//  }
//
//  /// 检测相关权限是否已经打开（根据已有权限名称）
//  static Future<bool> checkPermissionsByGroup(
//      List<PermissionGroup> lists) async {
//    bool result = true;
//
//    for (PermissionGroup permissionGroup in lists) {
//      PermissionStatus checkPermissionStatus =
//      await PermissionHandler().checkPermissionStatus(permissionGroup);
//
//      if (checkPermissionStatus != PermissionStatus.granted) {
//        result = false;
//        break;
//      }
//    }
//
//    return result;
//  }
//
//  /// 权限提示对话款
//  static showDialog(BuildContext cxt, String title, String content,
//      ActionNoParam ok, ActionNoParam cancel) {
//    showCupertinoDialog<int>(
//        context: cxt,
//        builder: (cxt) {
//          return CupertinoAlertDialog(
//            title: Text(title),
//            content: Text(content),
//            actions: <Widget>[
//              CupertinoDialogAction(
//                child: Text("去开启"),
//                onPressed: () {
//                  ok();
//                },
//              ),
//              CupertinoDialogAction(
//                child: Text("取消"),
//                onPressed: () {
//                  cancel();
//                },
//              )
//            ],
//          );
//        });
//  }
//}
