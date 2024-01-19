import 'package:flutter/material.dart';
import '../styles/colors.dart';

class DefaultText extends StatelessWidget {
  DefaultText({Key? key,this.text,this.textStyle,this.fontSize = 14,this.fontColor,this.fontWeight}) : super(key: key);
  String? text;
  FontWeight? fontWeight;
  double? fontSize;
  Color? fontColor = silverColor;
  dynamic textStyle;
  @override
  Widget build(BuildContext context) {
    return Text(
      '$text',
      overflow: TextOverflow.ellipsis,
      style: textStyle ?? TextStyle(
          fontSize: fontSize,
          color: fontColor,
          fontWeight: fontWeight
      ),
    );
  }
}