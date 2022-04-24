// ignore_for_file: prefer_const_constructors_in_immutables, unnecessary_this

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
class RaisedButtonCustomWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final dynamic onPressed;
  final Color borderColor;
  RaisedButtonCustomWidget({required this.icon, required this.text, required this.onPressed, this.borderColor = Colors.white });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        color: borderColor,
        onPressed: this.onPressed,
        child: Icon(this.icon, color: Colors.white,),);
  }
}