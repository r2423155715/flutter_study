import 'package:demo/public/login_input.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  VideoPlayerController videocon;
  bool isread = false;
  TextEditingController phonecon;
  TextEditingController codecon;
  static const String test_video3 =
      'http://212.64.95.5:8080/hrlweibo/file/weibo3.mp4';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videocon = VideoPlayerController.asset('image/weibo3.mp4')
      ..initialize().then((value) {
        setState(() {});
        videocon.play();
        videocon.setLooping(true);
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videocon.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: <Widget>[
          Transform.scale(
            scale: videocon.value.aspectRatio /
                MediaQuery.of(context).size.aspectRatio,
            child: Center(
              child: Container(
                child: videocon.value.initialized
                    ? AspectRatio(
                        aspectRatio: videocon.value.aspectRatio,
                        child: VideoPlayer(videocon),
                      )
                    : Text("正在初始化"),
              ),
            ),
          ),
          Positioned(
            bottom: 26.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: LoginInput(
                    controller: phonecon,
                    tishiyu1: '请输入手机号',
                    rightBtn: TextInputAction.go,
                    kType: TextInputType.phone,
                    ishsow: false,
                    showcode: true,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: LoginInput(
                    controller: codecon,
                    controller2: phonecon,
                    tishiyu1: '请输入验证码',
                    rightBtn: TextInputAction.go,
                    kType: TextInputType.phone,
                    ishsow: false,
                    showcode: false,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Checkbox(
                        value: isread,
                        activeColor: Colors.blue,
                        onChanged: (value) {
                          setState(() {
                            isread = value;
                          });
                        },
                      ),
                      Text(
                        "我已阅读并同意《服务协议》及《隐私政策》",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: FlatButton(
                    child: Text("登录", style: TextStyle(fontSize: 18)),
                    onPressed: () {},
                    color: Color(0xff202326),
                    textColor: Color(0xffededed),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
