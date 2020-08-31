import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingUtils {
  static BuildContext mContext;

  static dismiss() {
    try{
      if (mContext != null) {
        Navigator.pop(mContext);
        mContext = null;
      }
    }catch(e){

    }
  }

  static showLoading(BuildContext context) {
    if (context != null) {
      mContext = context;
      showGeneralDialog(
        context: context,
        barrierLabel: "",
        barrierDismissible: true,
        transitionDuration: Duration(milliseconds: 1),
        pageBuilder: (BuildContext context, Animation animation,
            Animation secondaryAnimation) {
          return Center(
            child: LoadingView(),
          );
        },
      );
    }
  }
// showGeneralDialog(context: mContext, child: new LoadingView());

}

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      child: new Material(
        borderOnForeground: false,
        color: Colors.transparent,
        child: new Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Color(0x00000000),
          child: new Center(
            child: new Container(
              height: 60,
              width: 60,
              alignment: Alignment.center,
              decoration: new BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(3),
              ),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
//                  new CupertinoActivityIndicator(
//                    radius: 10,
//                  ),
                  new Container(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      backgroundColor: Colors.pinkAccent,
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.pink),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      onWillPop: () {
        return Future.value(false);
      },
    );
  }
}
