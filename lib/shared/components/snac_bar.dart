import 'package:flutter/material.dart';

void defaultSnackBar({required BuildContext context , required String text , required Color color }) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Center(
      child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium
      ),
    ),
    backgroundColor: Theme.of(context).primaryColor,
  ));
}