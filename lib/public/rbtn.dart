import 'package:flutter/material.dart';

class Rbtn extends StatefulWidget {
  final double width;
  final double height;
  final Function onTap;
  final double radius;
  final int color;
  final String text;
  final int textColor;
  final double fontsize;
  final bool needborder;
  final int borderColor;

  const Rbtn(
      {Key key,
      this.width,
      this.height,
      this.onTap,
      this.radius,
      this.color,
      this.text,
      this.textColor,
      this.fontsize,
      this.needborder,
      this.borderColor,})
      : super(key: key);

  @override
  _RbtnState createState() => _RbtnState();
}

class _RbtnState extends State<Rbtn> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,

      child: Container(
        alignment: Alignment.center,
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: Color(widget.color),
          borderRadius: BorderRadius.all(
            Radius.circular(widget.radius),
          ),
          border: widget.needborder
              ? Border.all(width: 0.5, color: Color(widget.borderColor))
              : Border.all(width: 0, color: Colors.transparent),
        ),
        child: Text(
          widget.text,
          style: TextStyle(
              fontSize: widget.fontsize, color: Color(widget.textColor)),
        ),
      ),
    );
  }
}
