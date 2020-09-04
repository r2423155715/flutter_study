import 'package:demo/router/application.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class OneCatePage extends StatefulWidget {
  @override
  _OneCatePageState createState() => _OneCatePageState();
}

class _OneCatePageState extends State<OneCatePage> {
  List imgs = [
    'https://cdn.pixabay.com/photo/2012/03/01/00/21/bridge-19513__340.jpg',
    'https://cdn.pixabay.com/photo/2016/11/25/23/15/moon-1859616__340.jpg',
    'https://cdn.pixabay.com/photo/2016/05/05/02/37/sunset-1373171__340.jpg',
    'https://cdn.pixabay.com/photo/2014/07/30/02/00/iceberg-404966__340.jpg',
    'https://cdn.pixabay.com/photo/2017/04/28/16/29/landscape-2268775__340.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('第一个'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                height: 200,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        imgs[index],
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                  itemCount: imgs.length ?? 0,
                  //图片展页面的多少
                  viewportFraction: 0.8,
                  pagination: SwiperPagination(),
                  controller: SwiperController(),
                  loop: true,
//  两边图片缩放
                  scale: 0.9,
                  autoplay: true,
                ),
              ),
              Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width - 40,
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          'https://cdn.pixabay.com/photo/2017/04/28/16/29/landscape-2268775__340.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: InkWell(
                        onTap: () {
                          Application.router.navigateTo(context, '/video1',transition: TransitionType.fadeIn);
                        },
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 50,
                        )),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
