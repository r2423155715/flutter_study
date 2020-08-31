import 'package:flutter/material.dart';

class NoDataView extends StatefulWidget {
  final VoidCallback emptyRetry; //无数据事件处理

  NoDataView(this.emptyRetry);

  @override
  _NoDataViewState createState() => _NoDataViewState();
}

class _NoDataViewState extends State<NoDataView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.emptyRetry,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'image/empty.png',
              width: 200,
              height: 150,
            ),
            Text(
              '暂无数据',
              style: TextStyle(color: Color(0xffaaaaaa)),
            )
          ],
        ),
      ),
    );
  }
}
