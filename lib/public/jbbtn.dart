import 'package:flutter/material.dart';

class Jbbtn extends StatefulWidget {
  final double width;
  final double height;
  final Color startcolor;
  final Color endcolor;
  final Function onTap;
  final EdgeInsetsGeometry margin;
  final double radius;
  final String text;
  final Color textcolor;
  final double fontsize;

  const Jbbtn(
      {Key key,
      this.width,
      this.height,
      this.startcolor,
      this.endcolor = const Color(0xff3072fb),
      this.onTap,
      this.margin,
      this.radius = 20,
      this.text,
      this.textcolor=Colors.white,
      this.fontsize=15})
      : super(key: key);

  @override
  _JbbtnState createState() => _JbbtnState();
}

class _JbbtnState extends State<Jbbtn> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: widget.width,
        height: widget.height,
        alignment: Alignment.center,
        margin: widget.margin,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              widget.startcolor,
              widget.endcolor,
            ],
          ),
          borderRadius: BorderRadiusDirectional.circular(widget.radius),
        ),
        child: Text(
          widget.text,
          style:
              TextStyle(color: widget.textcolor,fontSize: widget.fontsize),
        ),
      ),
    );
  }
}
