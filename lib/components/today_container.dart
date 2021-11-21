import 'package:flutter/material.dart';
import 'package:softprism/components/transparent_container.dart';

class ReusableTodayContainer extends StatelessWidget {

  final BoxConstraints constraints;
  final String todayDate;
  final String degree;
  final String location;
  final String time;

  const ReusableTodayContainer({
    required this.constraints,
    required this.todayDate,
    required this.degree,
    required this.location,
    required this.time,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
        horizontalPadding: 10.0,
        verticalPadding: 35.0,
        widget: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// cloud image and date
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 60,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/WeatherIcon - 1-38.png'),
                        fit: BoxFit.cover
                    ),
                  ),
                ),
                const SizedBox(width: 7),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Today',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.4,
                      ),
                    ),
                    Text(
                      todayDate,
                      style: const TextStyle(
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
            ///temperature degree
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  degree,
                  style: const TextStyle(
                    fontSize: 150,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFFFFFFF),
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(width: 2.5),
                const Padding(
                  padding: EdgeInsets.only(top: 32.0),
                  child: Text(
                    '\u2103',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  location + ' •',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                const SizedBox(width: 4.5),
                Text(
                  time,
                  style: const TextStyle(
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
    );
  }
}