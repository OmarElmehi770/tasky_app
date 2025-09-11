import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showSuccess (String data , BuildContext context){
  Flushbar(
    message: data,
    icon: Icon(
      Icons.check_circle,
      size: 28.0,
      color: Colors.green,
    ),
    duration: Duration(seconds: 3),
    leftBarIndicatorColor: Colors.green,
  ).show(context);
}
void showError (String data , BuildContext context){
  Flushbar(
    message: data,
    icon: Icon(
      Icons.error,
      size: 28.0,
      color: Colors.red,
    ),
    duration: Duration(seconds: 3),
    leftBarIndicatorColor: Colors.red,
  ).show(context);
}