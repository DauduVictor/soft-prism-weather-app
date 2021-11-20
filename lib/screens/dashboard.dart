import 'package:flutter/material.dart';
import 'package:softprism/components/transparent_container.dart';
import 'package:softprism/screens/search_city.dart';
import 'package:softprism/utils/constants.dart';

class Dashboard extends StatefulWidget {

  static const String id = 'dashboard';
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin{

  /// Variable to hold the animation controller
  late AnimationController _controller;

  /// Variable to hold the tween value of [Custom Search Font Size]
  late Animation _fontSize;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this
    );

    _fontSize = Tween(begin: 18.0, end: 20.0).animate(_controller);

    _controller.addListener(() {
      setState(() {});
    });

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Location, notification widgets
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableTransparentContainer(
                      borderRadius: 20.0,
                      colorOpacity: 0.1,
                      horizontalPadding: 16.0,
                      verticalPadding: 14.0,
                      widget: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Icon(
                            Icons.location_on_sharp,
                            color: Colors.white,
                            size: 23,
                          ),
                          SizedBox(width: 4.1),
                          Text(
                            'Lagos, Nigeria',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                          ),
                          barrierColor: const Color(0xFFB9BCF2).withOpacity(0.6),
                          isDismissible: true,
                          enableDrag: false,
                          context: context,
                          builder: (context){
                            return _bottomNotificationModalSheet(constraints);
                          },
                        );
                      },
                      splashColor: Colors.white.withOpacity(0.3),
                      child: const ReusableTransparentContainer(
                        borderRadius: 10.0,
                        colorOpacity: 0.2,
                        horizontalPadding: 13.0,
                        verticalPadding: 11.0,
                        widget: Icon(
                          Icons.notifications,
                          color: Colors.white,
                          size: 27,
                        ),
                      ),
                    ),
                  ],
                ),
                ///Today's weather
                Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight * 0.399,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.43),
                    border: Border.all(
                      width: 0.77,
                      color:  const Color(0xFFB9BCF2),
                    ),
                  ),
                  child: ReusableTransparentContainer(
                    borderRadius: 15.43,
                    colorOpacity: 0.2,
                    horizontalPadding: 50.0,
                    verticalPadding: 44.0,
                    widget: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 80,
                              height: 40,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Today',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.4,
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  'Mon, 26 Apr',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.4,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              '28',
                              style: TextStyle(
                                fontSize: 150,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFFFFFFF),
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(width: 4.5),
                            Text(
                              'o C',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'Lagos, Nigeria' + ' •',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                            SizedBox(width: 4.5),
                            Text(
                              '2:00 p.m',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                /// Custom Search, Forecast Report Button
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, SearchCity.id);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              'Custom search ?',
                              style: TextStyle(
                                fontSize: _fontSize.value,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 23),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                          ),
                          barrierColor: const Color(0xFFB9BCF2).withOpacity(0.6),
                          isDismissible: true,
                          enableDrag: false,
                          context: context,
                          builder: (context){
                            return _bottomReportModalSheet(constraints);
                          },
                        );
                      },
                      splashColor: Colors.white.withOpacity(0.3),
                      child: ReusableTransparentContainer(
                        borderRadius: 8.01,
                        colorOpacity: 0.2,
                        horizontalPadding: 10.0,
                        verticalPadding: 21.0,
                        widget: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            SizedBox(width: 50),
                            Text(
                              'Forecast Report',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 21),
                            Icon(
                              Icons.keyboard_arrow_up_sharp,
                              color: Colors.white,
                              size: 24,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Widget for [Report Modal Sheet]
Widget _bottomReportModalSheet(BoxConstraints constraints) {
  return Container(
    height: constraints.maxHeight,
    decoration: const BoxDecoration(
      borderRadius:  BorderRadius.vertical(top: Radius.circular(30.0)),
      color: Colors.white,
    ),
    clipBehavior: Clip.hardEdge,
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 27),
        child: Column(
          children: [
            const SizedBox(height: 21),
            Container(
              width: constraints.maxWidth * 0.2,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF9D9D9D),
                  width: 1.2,
                ),
              ),
            ),
            const SizedBox(height: 21),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF7047EB).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20.0),
              ),
              clipBehavior: Clip.hardEdge,
              child: Material(
                child: InkWell(
                  onTap: () {
                  },
                  splashColor: const Color(0xFF7047EB).withOpacity(0.1),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'Forecast Report',
                          style: TextStyle(
                            color: kPurpleColor,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: kPurpleColor,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Today',
                style: kForeCastReportHeaderStyle,
              ),
            ),
            const SizedBox(height: 15.0),
            Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight * 0.12,
              decoration: kContainerDecoration,
            ),
            const SizedBox(height: 26.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Next Forecast',
                  style: kForeCastReportHeaderStyle,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: kPurpleColor,
                    borderRadius: BorderRadius.circular(8.01),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
                    child: const Center(
                      child: Text(
                        'Five Days',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight * 0.19,
              decoration: kContainerDecoration,
            ),
          ],
        ),
      ),
    ),
  );
}

/// Widget for [Notification Modal Sheet]
Widget _bottomNotificationModalSheet(BoxConstraints constraints) {
  return Container(
    height: constraints.maxHeight / 2,
    decoration: const BoxDecoration(
      borderRadius:  BorderRadius.vertical(top: Radius.circular(30.0)),
      color: Colors.white,
    ),
    clipBehavior: Clip.hardEdge,
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 27),
        child: Column(
          children: [
            const SizedBox(height: 21),
            Container(
              width: constraints.maxWidth * 0.2,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF9D9D9D),
                  width: 1.2,
                ),
              ),
            ),
            const SizedBox(height: 21),
            Container(
              width: constraints.maxWidth * 0.38,
              padding: const EdgeInsets.symmetric(vertical: 17.0, horizontal: 6.0),
              decoration: BoxDecoration(
                color: const Color(0xFF7047EB).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: const Center(
                child: Text(
                  'Your Notifications',
                  style: TextStyle(
                    color: kPurpleColor,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 19),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'New',
                style: kNotificationHeaderStyle,
              ),
            ),
            const SizedBox(height: 4),
            Column(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 52.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '10 minutes ago',
                      style: kNotificationHeaderStyle,
                    ),
                  ),
                ),
                ListTile(
                  horizontalTitleGap: 9,
                  contentPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  leading: Icon(Icons.wb_sunny, color: Color(0xFFFA9E42), size: 21),
                  title: Text(
                    'Its a sunny day in your location',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 19),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Earlier',
                style: kNotificationHeaderStyle,
              ),
            ),
            Column(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 52.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '10 minutes ago',
                      style: kNotificationHeaderStyle,
                    ),
                  ),
                ),
                ListTile(
                  horizontalTitleGap: 9,
                  contentPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  leading: Icon(Icons.wb_sunny, color: Color(0xFFFA9E42), size: 21),
                  title: Text(
                    'Its a sunny day in your location',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}