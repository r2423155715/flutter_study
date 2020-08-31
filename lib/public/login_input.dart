import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:demo/http/DioUtils.dart';
import 'package:demo/http/HttpUrls.dart';

class LoginInput extends StatefulWidget {
  final Function onchange; //input改变事件
  final Function onsubmit; //submit改变事件
  final String tishiyu1; //placeholder提示语
  final TextInputType kType; //输入框类型
  final bool ishsow; //是否显示(true就是类似密码框)
  final TextEditingController controller; //加了可以聚焦动态改变输入框类型
  final TextInputAction rightBtn; //右下角字样
  final bool showcode; //验证码
  final TextEditingController controller2; //第二个controller
  final int bgcolor; //背景色
  final int color; //字体颜色
  final int hitcolor; //placeholder颜色
  final double fontsize;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry padding1;
  final double radius;
  final FocusNode focus;

  const LoginInput(
      {Key key,
      this.radius,
      this.onchange,
      this.tishiyu1,
      this.kType = TextInputType.text,
      this.ishsow = false,
      this.controller,
      this.rightBtn,
      this.onsubmit,
      this.showcode = true,
      this.controller2,
      this.bgcolor = 0xffffffff,
      this.color = 0xff000000,
      this.hitcolor = 0xffd8d8d8,
      this.fontsize = 15,
      this.padding,
      this.padding1,
      this.focus})
      : super(key: key);

  @override
  _LoginInputState createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
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
    //获取验证码
    var data = {
      "phone": widget.controller2.text,
      "type": 1,
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
      width: MediaQuery.of(context).size.width-40,
      height: 45,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: widget.padding ?? EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(
        color: Color(widget.bgcolor),
        borderRadius: BorderRadius.all(Radius.circular(widget.radius ?? 40)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: TextField(
              focusNode: widget.focus,
              controller: widget.controller,
              obscureText: widget.ishsow,
              keyboardType: widget.kType ?? TextInputType.text,
              onChanged: (e) {
                print(e);
                if (widget.onchange != null) {
                  setState(() {});
                  widget.onchange();
                }
              },
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                contentPadding:
                    widget.padding1 ?? EdgeInsets.fromLTRB(10, 5, 10, 5),
                hintText: widget.tishiyu1,
                hintStyle: TextStyle(color: Color(widget.hitcolor)),
//                  fillColor: Colors.yellow,
//                  filled: true,
//                  border: InputBorder.none,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    borderSide: BorderSide.none),
              ),
              style: TextStyle(
                  color: Color(widget.color), fontSize: widget.fontsize),
              textInputAction: widget.rightBtn,
              onSubmitted: (e) {
                print('点击了${e}');
                if (widget.onsubmit != null) {
                  widget.onsubmit(e);
                }
              },
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
        ],
      ),
    );
  }
}
