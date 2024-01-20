import 'package:flutter/material.dart';
import '../styles/colors.dart';

class DefaultTextForm extends StatelessWidget {
  DefaultTextForm({super.key,
    required this.label, required this.controller,
    this.validator,this.keyboardType,this.onChange,
    this.isEnabled, this.prefix, this.suffix,
    this.onTap, this.readOnly = false});
  String label;
  String? hint;
  TextEditingController controller;
  String? Function(String?)? validator;
  TextInputType? keyboardType;
  Function(String)? onChange;
  Widget? prefix;
  Widget? suffix;
  bool? isEnabled;
  dynamic onTap;
  bool readOnly = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 176,
      child: TextFormField(
        onChanged: onChange,
        validator: validator ,
        controller: controller,
        keyboardType: keyboardType,
        onTap: onTap,
        enabled: isEnabled,
        style: const TextStyle(color:Colors.black),
        readOnly: readOnly,
        decoration: InputDecoration(
            contentPadding:  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            prefixIcon: prefix != null ? prefix : null,
            suffixIcon: suffix,
            errorStyle: const TextStyle(height: .8),
            label: Padding(
              padding:  const EdgeInsets.symmetric(horizontal: 0),
              child: Text(
                label,
                style: TextStyle(
                    color: textOnBoardingColor,
                    fontFamily: "poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w300
                ),
              ),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: textOnBoardingColor,
                )
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    color: mainColorDark
                )
            ),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    color: textOnBoardingColor
                )
            ),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    color: Colors.red
                )
            )
        ),
      ),
    );
  }
}
