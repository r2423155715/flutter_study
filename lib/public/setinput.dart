import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SetInput extends StatefulWidget {
  final double width;
  final double height;
  final TextEditingController controller;
  final String tishiyu1;
  final TextAlign textalign;
  final Function onchange;
  final TextInputType ktype;

  const SetInput(
      {Key key,
        this.width,
      this.height,
      this.controller,
      this.tishiyu1,
      this.textalign,
      this.onchange,
      this.ktype})
      : super(key: key);

  @override
  _SetInputState createState() => _SetInputState();
}

class _SetInputState extends State<SetInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width??80,
      height: widget.height,
      child: TextField(
        onChanged: widget.onchange,
        style: TextStyle(fontSize: 14),
        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
        keyboardType: widget.ktype??TextInputType.number,
        controller: widget.controller,
        textAlign: widget.textalign ?? TextAlign.right,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          hintText: widget.tishiyu1,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
