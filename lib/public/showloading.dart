import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
void showLoading(context, [String text]) {
  text = text ?? "Loading...";
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(3.0),
                boxShadow: [
                  //阴影
                  BoxShadow(
                    color: Colors.black12,
                    //offset: Offset(2.0,2.0),
                    blurRadius: 10.0,
                  )
                ]),
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(16),
            constraints: BoxConstraints(minHeight: 120, minWidth: 180),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget>[
            SizedBox(
            height: 30,
              width: 30,
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                text,
                style: Theme.of(context).textTheme.body2,
              ),
            ),
            ],
          ),
        ),
        );
      });
}

void showConfirmDialog(
    BuildContext context, String content, Function confirmCallback) {
  showDialog(
      context: context,
      builder: (context) {
        return new CupertinoAlertDialog(
          title: new Text("提示"),
          content: Container(margin: EdgeInsets.only(top: 10),child: new Text(content)),
          actions: <Widget>[
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                confirmCallback();
              },
              child: new Text("确认"),
            ),
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: new Text("取消"),
            ),
          ],
        );
      });
}
