import 'package:flutter/material.dart';
import 'package:softprism/screens/dashboard.dart';
import 'package:softprism/screens/search_city.dart';
import 'package:softprism/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'SoftPrism',
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id:(context) => const SplashScreen(),
        Dashboard.id:(context) => const Dashboard(),
        SearchCity.id:(context) => const SearchCity(),
      },
      theme: ThemeData(fontFamily: 'DMSans'),
    );
  }
}
