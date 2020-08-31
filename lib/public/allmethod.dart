import 'package:demo/http/DioUtils.dart';
import 'package:demo/http/HttpUrls.dart';
import 'package:demo/public/dateneed.dart';
import 'package:flutter/material.dart';
import 'package:common_utils/common_utils.dart';
import 'package:url_launcher/url_launcher.dart';

//选择年月日
showDataPicker(context) async {
  Locale myLocale = Localizations.localeOf(context);
  var picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
      locale: myLocale);
  print(
      "选择日期${picker.toString()}==========${DateUtil.formatDate(picker, format: DataFormats.y_mo_d)}");
  return DateUtil.formatDate(picker, format: DataFormats.y_mo_d).toString();
}

//选择时分秒
showTimePicker1(context1) async {
  var picker =
      await showTimePicker(context: context1, initialTime: TimeOfDay.now());
  print("选择时间${picker.hour}:${picker.minute}");
  return '${picker.hour}:${picker.minute}:00';
}

String timeconversion(int time) {
  int hour = 0;
  int minutes = 0;
  int seconds = 0;
  int temp = time % 3600;
  if (time > 3600) {
    hour = time ~/ 3600;
    if (temp != 0) {
      if (temp > 60) {
        minutes = temp ~/ 60;
        if (temp % 60 != 0) {
          seconds = temp % 60;
        }
      } else {
        seconds = temp;
      }
    }
  } else {
    minutes = time ~/ 60;
    if (time % 60 != 0) {
      seconds = time % 60;
    }
  }
  return (hour < 10 ? ("0" + hour.toString()) : hour.toString()) +
      "小时" +
      (minutes < 10 ? ("0" + minutes.toString()) : minutes.toString()) +
      "分" +
      (seconds < 10 ? ("0" + seconds.toString()) : seconds.toString()) +
      "秒";
}


String SurationTransform(int time) {
  int day=0;
  int hour = 0;
  int minutes = 0;
  int seconds = 0;
  day=time~/(60*60*24);
  hour=(time-(day*60*60*24))~/(60*60);
  minutes=(time-(day*60*60*24)-(hour*60*60))~/60;
  seconds=time%60;
  return day.toString() +
      "天" +
      (hour < 10 ? ("0" + hour.toString()) : hour.toString()) +
      "小时" +
      (minutes < 10 ? ("0" + minutes.toString()) : minutes.toString()) +
      "分" +
      (seconds < 10 ? ("0" + seconds.toString()) : seconds.toString()) +
      "秒";
}
String timeconversion1(int time) {
  int day = 0;
  int hour = 0;
  int minutes = 0;
  int seconds = 0;
  int temp = time % 3600;
  if (time > 3600 * 24) {
    day = time ~/ (3600 * 24);
    time = time - (day * 3600 * 24);
    if (time > 3600) {
      hour = time ~/ 3600;
      if (temp != 0) {
        if (temp > 60) {
          minutes = temp ~/ 60;
          if (temp % 60 != 0) {
            seconds = temp % 60;
          }
        } else {
          seconds = temp;
        }
      }
    }
  } else {
    hour = time ~/ 3600;
    minutes = time ~/ 60;
    if (time % 60 != 0) {
      seconds = time % 60;
    }
  }
  return day.toString() +
      "天" +
      (hour < 10 ? ("0" + hour.toString()) : hour.toString()) +
      "小时" +
      (minutes < 10 ? ("0" + minutes.toString()) : minutes.toString()) +
      "分" +
      (seconds < 10 ? ("0" + seconds.toString()) : seconds.toString()) +
      "秒";
}

//上传错误
senderr(err) {
  DioUtils.instance
      .post(HttpUrls.bug_log, data: {"content": err}, onSucceed: (data) {});
}

//打电话
callphone(number) async {
  String url = 'tel:' + number;
//    String url='https:'+'www.bilibili.com/video/BV1eJ411q7V3?p=14';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw "url can't use";
  }
}
