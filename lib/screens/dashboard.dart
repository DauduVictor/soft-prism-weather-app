import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:softprism/bloc/future_values.dart';
import 'package:softprism/components/header_location.dart';
import 'package:softprism/components/today_container.dart';
import 'package:softprism/components/transparent_container.dart';
import 'package:softprism/location/location.dart';
import 'package:softprism/model/forecast_weather_model.dart';
import 'package:softprism/model/weather_model.dart';
import 'package:softprism/screens/search_city.dart';
import 'package:softprism/utils/constants.dart';
import 'package:softprism/utils/functions.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatefulWidget {

  static const String id = 'dashboard';
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin{

  /// Instantiating a class of the [LocationHelper]
  var location = LocationHelper();

  /// Variable to hold the animation controller
  late AnimationController _controller;

  /// Variable to hold the curve animation
  late CurvedAnimation _curve;

  /// Variable to hold the color value for the snapshot animation
  late Animation _flashTween;

  /// Variable to hold the curve animation
  late CurvedAnimation _snapCurve;

  ///Instantiating a class for [FutureValues]
  var _futureValue = FutureValues();

  ///Variable to hold the temperature
  double? temp;

  ///Variable to hold the temperature
  double? lat;

  ///Variable to hold the temperature
  double? lon;

  ///Variable to hold the description
  String description = '';

  ///Instance of [DateTime] class
  var now = DateTime.now();

  ///Variable to format date in [DD-MM] format
  String? _dayMonthFormat;

  ///Variable to format date in [MM-DD] format
  late final _monthDayFormat;

  ///A variable to hold the city and state of the custom location search
  String? cityStateLocation;

  /// Variable to hold the greeting
  String? _greeting;

  ///Global key for RefreshIndicatorState to refresh weather data
  final GlobalKey<RefreshIndicatorState> _refreshWeatherKey = GlobalKey<RefreshIndicatorState>();

  /// Function that shows greetings based on the users local time
  void _greetingMessage() {

    ///Instance of [DateTime] class
    var now = DateTime.now().hour;
    if (now < 12) {
      setState(() => _greeting = 'Good Morning');
    }
    else if (now < 17) {
      setState(() => _greeting = 'Good Afternoon');
    }
    else {
      setState(() => _greeting = 'Good Evening');
    }
  }

  ///Function to get users long and lat with [Location_Helper]
  void _getUserLocation() async{
    await location.getLocation();
      setState((){
        lat = location.lat; //6.5;
        lon = location.lat; //3.3; location.long;
      });
    getAddress(lat, lon);
  }

  /// Function to get finer location details based on the long and lat
  Future<void> getAddress(double? latitude, double? longitude) async{
    List<Placemark> placeMarks = await placemarkFromCoordinates(latitude!, longitude!);
    Placemark place = placeMarks[0];
    setState(() {
      cityStateLocation = ('${place.locality}, ${place.country}');
    });
  }

  /// A Function to get weather data from the api
  void  _getCurrentWeatherData() async {
    await _futureValue.getUserData().then((WeatherData value) async {
      setState(() {
        temp = value.main!.temp;
        description = value.weather![0].description.toString();
      });
      _getAllWeatherFutureForecast();
    }).catchError((e) {
      if(!mounted) return;
      Functions.showMessage(e);
    });
  }

  /// A variable to hold daily and hourly weather data
  ForecastWeatherData? _weatherData;


  /// A function to fetch all WeatherData
  void _getAllWeatherFutureForecast() async{
    Future<ForecastWeatherData> weatherData = _futureValue.getUserForecastData();
    await weatherData.then((ForecastWeatherData value){
      if(!mounted) return;
      setState((){
        _weatherData = value;
      });
      _getOfflineWeatherDescriptionHistory();
    }).catchError((e){
      if(!mounted)return;
    });
  }

  ///A widget list that holds the hourly forecast
  List<Widget> _buildHourForecast(){
    List<Widget> list = [];
    if(_weatherData!= null){
      for(int i = 1; i < 6; i++){
        list.add(_hourlyForecast(_weatherData!.hourly![i], i));
      }
      return list;
    }
    else{
      list.add(Container());
      return list;
    }

  }

  ///Widget used in the hourly forecast container
  Widget _hourlyForecast(Hourly wData, int i) {
    /// Variable to help increase time interval by 2 hours
    int _nextHour = i * 2;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('${wData.temp!.round()} \u2103'),
        const SizedBox(height: 4),
        Container(
          height: 32,
          width: 32,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/WeatherIcon - 1-22.png'),
              fit: BoxFit.contain
            ),
          ),
        ),
        const SizedBox(height: 1),
        Text(DateFormat.j().format(DateTime.now().add(Duration(hours: _nextHour)))),
      ],
    );
  }

  ///A widget to build next 5 days weather forecast
  Widget _buildFutureForecast(){
    List<DataRow> itemRow = [];
    if(_weatherData!= null){
      for(int i = 1; i < 6; i++){
        Daily wData = _weatherData!.daily![i];
        String date = _monthDayFormat!.format(now.add(Duration(days: i)));
        itemRow.add(
          DataRow(cells: [
            DataCell(Text(date)),
            DataCell(Container(
              width: 50,
              height: 30,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/WeatherIcon - 1-23.png'),
                    fit: BoxFit.contain
                ),
              ),
            )),
            DataCell(Text('${wData.temp!.day!.round()} \u2103')),
          ]),
        );
      }
      return DataTable(
        dataTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        dataRowHeight: 65.0,
        headingRowHeight: 0,
        columns: const [
          DataColumn(label: Text('')),
          DataColumn(label: Text('')),
          DataColumn(label: Text('')),
        ],
        rows: itemRow,
      );
    }
    return Container();
  }

  /// A function to refresh the dashboard state by calling[initState]
  Future<void> _refreshDashboard()  async {
    setState((){
      temp = null;
      lat = null;
      lon = null;
      description = '';
      _weatherData = null;
    });

  }

  /// A function to get the file holding [Weather_Description_History]
  void _getOfflineWeatherDescriptionHistory() {
    _futureValue.getDescriptionHistory();
  }

  /// bool Variable to hold the state of the snapshot which is determined by [_controller]
  bool _showSnap = false;

  @override
  void initState() {
    super.initState();
    _dayMonthFormat = DateFormat('EEEE, dd MMM').format(now);
    _monthDayFormat = DateFormat('MMM dd');
    _greetingMessage();
    _getUserLocation();
    _getCurrentWeatherData();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this
    );

    _controller.addListener(() {
      setState(() {
        if(_controller.value > 0.7) {
          setState(() => _showSnap = true);
        }
        else {
          _showSnap = false;
        }
      });
    });

    _controller.repeat(
      reverse: true
    );

    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _snapCurve = CurvedAnimation(parent: _controller, curve: Curves.linear);

    _flashTween = ColorTween(begin: Colors.transparent, end: Colors.white.withOpacity(0.37)).animate(_snapCurve);

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
          builder: (context, constraints) => RefreshIndicator(
            key: _refreshWeatherKey,
            onRefresh: _refreshDashboard,
            backgroundColor: Colors.white,
            color: kPurpleColor,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                height: constraints.maxHeight,
                padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Location, notification widgets
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ReusableHeaderLocation(
                                location: cityStateLocation == null ? 'City, Country' : cityStateLocation!,
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
                                      return _bottomNotificationModalSheet(constraints, description);
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
                          const SizedBox(height: 30),
                          /// Greeting text
                          Text(
                            _greeting != null ? _greeting! : 'Good day',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 29,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          /// Description
                          Text(
                            description == ''  ? 'Loading...' : description.toString() ,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.1),
                    /// Today's weather
                    ReusableTodayContainer(
                      constraints: constraints,
                      todayDate: _dayMonthFormat!,
                      degree: temp == null ? '0' : temp!.round().toString(),
                      location: cityStateLocation == null ? 'City, Country' : cityStateLocation!,
                      time: DateFormat.jm().format(DateTime.now()),
                    ),
                    const Spacer(),
                    /// Custom Search, Forecast Report Button
                    Padding(
                      padding: const EdgeInsets.only(bottom: 27.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AnimatedBuilder(
                            animation: _controller,
                            builder: (context, child) {
                              return Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  Container(
                                    height: 58,
                                    width: 178.5,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(19),
                                      border: Border.all(
                                        width: 1.7,
                                        color: _showSnap == true ? _flashTween.value : Colors.transparent,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, SearchCity.id);
                                    },
                                    child: Material(
                                      color: Colors.transparent,
                                      elevation: 3,
                                      borderRadius: BorderRadius.circular(19),
                                      shadowColor: kPurpleColor.withOpacity(0.1),
                                      child: Container(
                                        clipBehavior: Clip.hardEdge,
                                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 9.0),
                                        decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(19),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.white.withOpacity(0.07),
                                                spreadRadius: _curve.value * 12,
                                              ),
                                            ]
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Text(
                                              'Custom search',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Icon(
                                              Icons.search,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                                ),
                                barrierColor: const Color(0xFFB9BCF2).withOpacity(0.6),
                                isDismissible: true,
                                enableDrag: false,
                                builder: (context){
                                  return _bottomReportModalSheet(constraints, context, _buildFutureForecast(), _buildHourForecast());
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Widget for [Report Modal Sheet]
Widget _bottomReportModalSheet(
    BoxConstraints constraints,
    BuildContext context,
    Widget table,
    List<Widget> hForcast
    ) {
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
            ///Divider
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
            ///forecast report button dissmisal
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF7047EB).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20.0),
              ),
              clipBehavior: Clip.hardEdge,
              child: Material(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
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
            ///today - hourly forecast
            Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight * 0.12,
              decoration: kContainerDecoration,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: hForcast,
              ),
            ),
            const SizedBox(height: 26.0),
            ///next forecast
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
              decoration: kContainerDecoration,
              clipBehavior: Clip.hardEdge,
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: table,
            ),
          ],
        ),
      ),
    ),
  );
}

/// Widget for [Notification Modal Sheet]
Widget _bottomNotificationModalSheet(BoxConstraints constraints, String description) {
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
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 52.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Just now',
                      style: kNotificationHeaderStyle,
                    ),
                  ),
                ),
                ListTile(
                  horizontalTitleGap: 9,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  leading: const Icon(Icons.wb_sunny, color: Color(0xFFFA9E42), size: 21),
                  title: Text(
                    description != '' ? '$description at your location' : 'Loading...',
                    style: const TextStyle(
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
            /// data coming from the users storage / database (dummy data)
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
                    'Its a sunny day at your location',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 52.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Yesterday',
                      style: kNotificationHeaderStyle,
                    ),
                  ),
                ),
                ListTile(
                  horizontalTitleGap: 9,
                  contentPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  leading: Icon(Icons.wb_sunny, color: Color(0xFFFA9E42), size: 21),
                  title: Text(
                    'Cloudy at your location',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 52.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '2 days ago',
                      style: kNotificationHeaderStyle,
                    ),
                  ),
                ),
                ListTile(
                  horizontalTitleGap: 9,
                  contentPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  leading: Icon(Icons.wb_sunny, color: Color(0xFFFA9E42), size: 21),
                  title: Text(
                    'Few clouds at your location',
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