import 'package:flutter/material.dart';

import '../styles/colors.dart';


class DefaultTextField extends StatelessWidget {
  DefaultTextField({
    Key? key,
    this.prefix,
    this.hintText,
    this.textInputType,
    this.height,
    this.suffix,
    this.color,
    this.controller,
    this.borderRadius,
    this.onSubmitted,
    this.onTap,
    this.validator,
    this.obscureText = false
  }) : super(key: key);

  double? height;
  Widget? prefix;
  Widget? suffix;
  TextInputType? textInputType;
  String? hintText;
  double? width;
  Color? color ;
  TextEditingController? controller;
  var onSubmitted;
  var onTap;
  double? borderRadius;
  bool obscureText;
  dynamic validator;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: silverColor)
        ),
        child: TextFormField(
          onTap: onTap,
          validator: validator,
          onFieldSubmitted: onSubmitted,
          controller: controller,
          keyboardType: textInputType,
          obscureText: obscureText,
          style: TextStyle(color: silverColor,),
          decoration: InputDecoration(
            prefixIcon: prefix != null ? prefix : null,
            suffixIcon: suffix,
            prefix: prefix != null ? null : SizedBox(width: 10),
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 12,fontWeight: FontWeight.w700, color: silverColor),
          ),
        )
    );
  }
}