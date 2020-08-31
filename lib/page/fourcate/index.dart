import 'package:demo/router/application.dart';
import 'package:flutter/material.dart';

class FourCatePage extends StatefulWidget {
  @override
  _FourCatePageState createState() => _FourCatePageState();
}

class _FourCatePageState extends State<FourCatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第四个'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            FlatButton(
              color: Colors.red,
              onPressed: () {
                Application.router.navigateTo(context, '/login');
              },
              child: Text('登录'),
            ),
          ],
        ),
      ),
    );
  }
}
