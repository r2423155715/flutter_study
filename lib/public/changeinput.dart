import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:demo/http/DioUtils.dart';
import 'package:demo/http/HttpUrls.dart';

class Changeinput extends StatefulWidget {
  final double height;
  final TextEditingController controller;
  final TextEditingController controller2;
  final bool isshow;
  final TextInputType kType;
  final bool showcode;
  final String tishiyu;
  final bool showicon;
  final Function changeshow;
  final bool icontype;

  const Changeinput(
      {Key key,
      this.height,
      this.controller,
      this.isshow,
      this.kType,
      this.showcode,
      this.controller2,
      this.tishiyu,
      this.showicon = true,
      this.changeshow,
      this.icontype = false})
      : super(key: key);

  @override
  _ChangeinputState createState() => _ChangeinputState();
}

class _ChangeinputState extends State<Changeinput> {
  void sendMsg() {
    FocusManager.instance?.primaryFocus?.unfocus();
    if (widget.controller2.text.length == 0) {
      print("手机号${widget.controller2.text}");
      Fluttertoast.showToast(msg: '请输入手机号', gravity: ToastGravity.CENTER);
      return;
    }
    if (widget.controller2.text.length != 11) {
      print("手机号${widget.controller2.text}");
      Fluttertoast.showToast(msg: '请输入正确手机号', gravity: ToastGravity.CENTER);
      return;
    }
    //      获取验证码
    var data = {
      "phone": widget.controller2.text,
      "type": 2,
      "sign": EncryptUtil.encodeMd5("astgo" + widget.controller2.text)
    };
    DioUtils.instance.post(HttpUrls.getverify, data: data, context: context,
        onSucceed: (response) {
      print("获取验证码接口返回数据");
      Fluttertoast.showToast(msg: '发送成功');
      // Timer的第一秒倒计时是有一点延迟的，为了立刻显示效果可以添加下一行。
      _reGetCountdown();
    });
  }

  //  定时器
  Timer _countdownTimer;
  String _codeCountdownStr = '获取验证码';
  int _countdownNum = 59;

//  倒计时方法
  //  倒计时方法
  void _reGetCountdown() {
    _codeCountdownStr = '${_countdownNum--}s重新获取';
    _countdownTimer = new Timer.periodic(new Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdownNum > 0) {
          _codeCountdownStr = '${_countdownNum--}s重新获取';
        } else {
          _codeCountdownStr = '获取验证码';
          _countdownNum = 59;
          _countdownTimer.cancel();
          _countdownTimer = null;
        }
      });
    });
  }

  // 不要忘记在这里释放掉Timer
  @override
  void dispose() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: widget.height,
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              maxLines: 1,
              controller: widget.controller,
              obscureText: widget.isshow,
              keyboardType: widget.kType ?? TextInputType.text,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0),
//                filled: true,
//                fillColor: Colors.blue,
                hintText: widget.tishiyu,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide.none),
              ),
            ),
          ),
          Offstage(
            offstage: widget.showcode,
            child: Container(
              width: 100,
              alignment: Alignment.center,
              child: InkWell(
                  onTap: () {
                    if (_codeCountdownStr == "获取验证码") {
                      sendMsg();
                    }
                  },
                  child: Text(
                    _codeCountdownStr,
                    style: TextStyle(color: Color(0xff3072fb)),
                  )),
            ),
          ),
          Offstage(
            offstage: widget.showicon,
            child: Container(
//              color: Colors.blue,
              padding: EdgeInsets.only(right: 13),
              width: 100,
              alignment: Alignment.centerRight,
              child: InkWell(
                  onTap: () {
                    widget.changeshow();
                  },
                  child: Image.asset(
                    widget.icontype ? 'image/look.png' : 'image/hide.png',
                    width: 25,
                    height: 25,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
