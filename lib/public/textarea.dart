import 'package:flutter/material.dart';

class Textarea1 extends StatefulWidget {
  final TextEditingController controller;
  final String tishiyu;
  final bool isred;
  final int line;
  final int hintStyle;

  const Textarea1(
      {Key key,
      this.controller,
      this.tishiyu,
      this.isred = false,
      this.line = 5,
      this.hintStyle = 0xffd6d6d6d})
      : super(key: key);

  @override
  _Textarea1State createState() => _Textarea1State();
}

class _Textarea1State extends State<Textarea1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        readOnly: widget.isred,
        style: TextStyle(fontSize: 14),
        maxLines: widget.line,
        controller: widget.controller,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          fillColor: Color(0XFFf8f8f8),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent, //边线颜色为白色
              width: 0, //边线宽度为2
            ),
          ),
          contentPadding: EdgeInsets.all(10),
          hintText: widget.tishiyu,
          hintStyle: TextStyle(color: Color(widget.hintStyle),),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
