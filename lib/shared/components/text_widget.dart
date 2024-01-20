import 'package:flutter/material.dart';

class TextCustomWidget extends StatelessWidget{
  TextCustomWidget({super.key, this.text, this.fontWeight,
    this.fontColor, this.fontFamily, this.fontSize, this.textAlign, this.textDecoration});
  String? text, fontFamily;
  double? fontSize;
  Color? fontColor;
  FontWeight? fontWeight;
  TextAlign? textAlign;
  TextDecoration? textDecoration;
  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: fontColor,
        fontFamily: fontFamily,
        decoration: textDecoration,
      ),
      textAlign: textAlign,

    );
  }
}