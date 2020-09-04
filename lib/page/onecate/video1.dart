import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class Video1Page extends StatefulWidget {
  @override
  _Video1PageState createState() => _Video1PageState();
}

class _Video1PageState extends State<Video1Page> {
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //配置视频地址
    videoPlayerController = VideoPlayerController.network(
        'http://212.64.95.5:8080/hrlweibo/file/weibo3.mp4');
    print('videoPlayerController=====${videoPlayerController}');
    chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
//        aspectRatio: 3 / 2,
        //宽高比
        autoPlay: true,
        //自动播放
        looping: false,
        //循环播放
        //是否显示全屏控件
        allowFullScreen: true,
//        播放是否全屏
        allowedScreenSleep: true,
        //定义玩家是否会全屏睡眠
        autoInitialize: false,
//        开始是否显示控制器
        showControlsOnInitialize: false,
//        自定义组件//默认的控制器就不显示了
//        customControls: Container(
//          width: double.infinity,
//          height: 30,
//          color: Colors.blue,
//        ),
        //加载中显示
        placeholder: Container(
          alignment: Alignment.center,
          child: Image.asset(
            'image/loading.png',
            fit: BoxFit.cover,
          ),
        ),
//        介于customControls和视频之间的控件
//        overlay: Container(
//          width: double.infinity,
//          height:50 ,
//          color: Colors.yellow,
//        ),
//        播放是否全屏
        fullScreenByDefault: false,
        //静音控件
        allowMuting: true);
    print('chewieController====${chewieController}');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: new Center(
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              child: new Chewie(
                controller: chewieController,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                margin:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                width: MediaQuery.of(context).size.width,
                color: Color.fromRGBO(255, 255, 255, 0.2),
                height: 46,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
