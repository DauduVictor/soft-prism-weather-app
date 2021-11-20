import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircleProgressIndicator extends StatelessWidget {

  const CircleProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? const CupertinoActivityIndicator(radius: 14)
        : const CircularProgressIndicator(
      strokeWidth: 3.2,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
    );
  }
}