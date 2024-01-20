import 'package:accounting/shared/components/text_widget.dart';
import 'package:flutter/material.dart';

class ButtonCustomWidget extends StatelessWidget {
  ButtonCustomWidget({super.key, this.text, this.color,
    this.buttonColor, this.buttonWidth, this.onPressed, this.buttonHeight});
  String? text;
  Color? color;
  Color? buttonColor;
  double? buttonWidth;
  double? buttonHeight;
  dynamic onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonWidth,
      height: buttonHeight,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(19),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: TextCustomWidget(
          text: "$text",
          fontColor: color,
        ),
      ),
    );
  }
}
