import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Functions{

  static void showMessage(String message){
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color(0xFFFFFFFF),
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }

}