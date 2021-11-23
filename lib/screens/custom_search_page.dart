import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:softprism/components/header_location.dart';
import 'package:softprism/components/today_container.dart';
import 'package:softprism/model/weather_model.dart';
import 'package:softprism/utils/constants.dart';
import 'package:geocoding/geocoding.dart';

class CustomSearchPage extends StatefulWidget {

  static const String id = 'customSearchPage';

  const CustomSearchPage({
    this.weatherModel,
    Key? key,
  }) : super(key: key);

  final WeatherData? weatherModel;

  @override
  _CustomSearchPageState createState() => _CustomSearchPageState();
}

class _CustomSearchPageState extends State<CustomSearchPage> {

  ///A variable to hold the city and state of the custom location search
  String? cityStateLocation;

  // TimeZone tz = TimeZone.getTimeZone(country + "/" + city);

  ///Instance of [DateTime] class
  var now = DateTime.now();

  // DateTime.now().add(Duration(seconds: timezone - DateTime.now().timeZoneOffset.inSeconds));

  ///Variable to format date in [DD-MM] format
  String? _dayMonthFormat;

  /// Function to get finer location details based on the long and lat returned by the api for custom search
  Future<void> getAddress(double latitude, double longitude) async{
    List<Placemark> placeMarks = await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placeMarks[0];
    setState(() {
      cityStateLocation = ('${place.locality}, ${place.country}');
    });
  }

  @override
  void initState() {
    super.initState();
    getAddress(9.076479, 7.398574);
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
                    ReusableHeaderLocation(
                      location: cityStateLocation!,
                    ),
                  ],
                ),
                SizedBox(height: constraints.maxHeight * 0.165),
                ///Today's weather
                ReusableTodayContainer(
                  constraints: constraints,
                  todayDate: 'Mon, 26 Apr',
                  degree: '0', /**widget.weatherModel!.main!.temp!.round().toString()**/
                  location: cityStateLocation!,
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
