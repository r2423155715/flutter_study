import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:demo/http/DioUtils.dart';
import 'package:demo/http/HttpUrls.dart';
import 'package:demo/public/login_input.dart';
import 'package:demo/router/application.dart';
import 'package:demo/statepage/nodata.dart';

class SearchBarDemo extends StatefulWidget {
  final String type;
  final String searchtype;

  const SearchBarDemo({Key key, this.type, this.searchtype}) : super(key: key);

  @override
  _SearchBarDemoState createState() => _SearchBarDemoState();
}

class _SearchBarDemoState extends State<SearchBarDemo> {
  Timer timer;
  List allpeople = [];
  TextEditingController textcon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LoginInput(
          controller: textcon,
          padding: EdgeInsets.all(5),
          tishiyu1: '请输入查询人姓名',
          radius: 20,
          onchange: () {
            if (timer != null) {
              timer.cancel();
              timer = null;
            }
            setState(() {});
            timer = Timer(Duration(milliseconds: 200), () {
              if (timer != null) {
                timer.cancel();
                timer = null;
                print("掉接口");
                getpersonlist(widget.searchtype);
              }
            });
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              textcon.text = '';
              setState(() {});
            },
          )
        ],
      ),
      body: Container(
        child: allpeople.length == 0
            ? NoDataView(() {
                return;
              })
            : ListView.builder(
                shrinkWrap: true,
                itemCount: allpeople.length ?? 0,
                itemBuilder: (item, index) {
                  return evepersonmsg(index);
                }),
      ),
    );
  }

//  ========================
//  组件
  //每一个人
  Widget evepersonmsg(index) {
    return InkWell(
      onTap: () {
        if (widget.type == 'giveother') {
          Navigator.of(context).pop(allpeople[index]);
        } else if (widget.type == 'sendmsg') {
          Map obj = {
            "id": allpeople[index]['id'],
            "name": allpeople[index]['agentname'],
            "sendtype": widget.searchtype,
            "type": 'send'
          };
          Application.router.navigateTo(
              context, '/sendmsg?msg=${Uri.encodeComponent(jsonEncode(obj))}');
        }
      },
      child: Container(
        padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 0.5, color: Color(0xffcccccc)))),
        child: Text(
            '${allpeople[index]['agentname']}   ${allpeople[index]['phone']}'),
      ),
    );
  }

//方法
  getpersonlist(type) {
    DioUtils.instance.post(HttpUrls.usersearch,
        data: {"name": textcon.text, "type": type}, onSucceed: (data) {
      allpeople = data;
      setState(() {});
    });
  }
}
