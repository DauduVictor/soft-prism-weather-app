import 'package:flutter/material.dart';
import 'package:softprism/components/header_location.dart';
import 'package:softprism/components/today_container.dart';
import 'package:softprism/utils/constants.dart';

class CustomSearchPage extends StatefulWidget {

  static const String id = 'customSearchPage';

  const CustomSearchPage({
    Key? key
  }) : super(key: key);

  @override
  _CustomSearchPageState createState() => _CustomSearchPageState();
}

class _CustomSearchPageState extends State<CustomSearchPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: kPurpleColor,
        body: LayoutBuilder(
          builder: (context, constraints) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 47),
            height: constraints.maxHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Go back, Location
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.keyboard_arrow_left_sharp,
                        color: Color(0xFFFFFFFF),
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 3),
                    const ReusableHeaderLocation(
                      location: 'Lagos, Abuja',
                    ),
                  ],
                ),
                SizedBox(height: constraints.maxHeight * 0.165),
                ///Today's weather
                ReusableTodayContainer(
                  constraints: constraints,
                  todayDate: 'Mon, 26 Apr',
                  degree: '28',
                  location: 'Lagos, Abuja',
                  time: '2:00 p.m',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
