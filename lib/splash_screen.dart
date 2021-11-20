import 'dart:async';
import 'package:flutter/material.dart';
import 'package:softprism/screens/dashboard.dart';
import 'package:softprism/utils/constants.dart';

class SplashScreen extends StatefulWidget {

  static const String id = 'splashScreen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  /// Function to navigate to the dashboard after 3 seconds
  void _navigate() {
    Timer(const Duration(seconds: 3), ()=> Navigator.pushReplacementNamed(context, Dashboard.id));
  }

  @override
  void initState() {
    super.initState();
    _navigate();
  }
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: kPurpleColor,
          body: Center(
            child: Text(
              'Soft Prism',
              style: TextStyle(
                color: Colors.white,
                fontSize: 38,
                 fontWeight: FontWeight.w600,
              ),
            ),
          ),
        )
    );
  }
}
