import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  ///Instance of [DateTime] class
  var now = DateTime.now();

  ///Variable to format date in [DD-MM] format
  String? _dayMonthFormat;

  /// Function to get finer location details based on the long and lat returned by the api for custom search
  Future<void> getAddress(double? latitude, double? longitude) async{
    List<Placemark> placeMarks = await placemarkFromCoordinates(latitude!, longitude!);
    Placemark place = placeMarks[0];
    setState(() {
      cityStateLocation = ('${place.locality}, ${place.country}');
    });
  }

  @override
  void initState() {
    super.initState();
    _dayMonthFormat = DateFormat('EEEE, dd MMM').format(now);
    getAddress(widget.weatherModel!.coord!.lat, widget.weatherModel!.coord!.lon);
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
                      location: cityStateLocation == null ? 'City, Country' : cityStateLocation!,
                    ),
                  ],
                ),
                SizedBox(height: constraints.maxHeight * 0.165),
                ///Today's weather
                ReusableTodayContainer(
                  constraints: constraints,
                  todayDate: _dayMonthFormat == null ? 'D MM YYYY' :_dayMonthFormat!,
                  degree: widget.weatherModel!.main!.temp!.round().toString(),
                  location: cityStateLocation == null ? 'City, Country' : cityStateLocation!,
                  time: DateFormat.jm().format(DateTime.now()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
