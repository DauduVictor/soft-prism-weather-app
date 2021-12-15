import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:softprism/components/circle_progress_indicator.dart';
import 'package:softprism/components/transparent_container.dart';
import 'package:softprism/model/weather_model.dart';
import 'package:softprism/networking/user_data_source.dart';
import 'package:softprism/utils/constants.dart';
import 'package:softprism/utils/functions.dart';
import 'custom_search_page.dart';

class SearchCity extends StatefulWidget {

  static const String id = 'searchCity';
  const SearchCity({Key? key}) : super(key: key);

  @override
  _SearchCityState createState() => _SearchCityState();
}

class _SearchCityState extends State<SearchCity> {

  /// Variable to hold the bool value of the [CircleIndicator()]
  bool _showSpinner = false;

  /// A [GlobalKey] to hold the form state of search form widget for form validation
  final _formKey = GlobalKey<FormState>();

  /// A [TextEditingController] to control the input text for the search city
  TextEditingController _searchController = TextEditingController();

  /// Variable which holds weather model which would be sent to the required screen
  WeatherData? weatherData;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: kPurpleColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          foregroundColor: Colors.white,
        ),
        body: GestureDetector(
          onTap: (){
            FocusScopeNode currentFocus = FocusScope.of(context);
            if(!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
          },
          child: AbsorbPointer(
            absorbing: _showSpinner,
            child: LayoutBuilder(
              builder: (context, constraints) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 47),
                height: constraints.maxHeight,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// Search box
                      _searchBox(),
                      /// Search Button
                      InkWell(
                        onTap: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if(!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
                          if (!_showSpinner){
                            if(_formKey.currentState!.validate()){
                              _search();
                            }
                          }
                        },
                        splashColor: Colors.white.withOpacity(0.3),
                        child: ReusableTransparentContainer(
                          borderRadius: 10.0,
                          colorOpacity: 0.2,
                          horizontalPadding: 13.0,
                          verticalPadding: 11.0,
                          widget: _showSpinner ?
                          const SizedBox(
                            width: 25,
                            height: 25,
                            child: CircleProgressIndicator(),
                          ) : const Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 27,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Widget to custom search
  Widget _searchBox() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Search
          Container(
            width: double.infinity,
            child: TextFormField(
              cursorColor: Colors.white,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.normal,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(21.0, 14.0, 21.0, 14.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3.0),
                ),
                enabledBorder: kOutlinedBorderSearchStyle,
                focusedBorder: kOutlinedBorderSearchStyle,
                focusedErrorBorder: kOutlinedBorderSearchStyle,
                errorBorder: kOutlinedBorderSearchStyle,
                errorStyle: const TextStyle(color: Colors.white),
                hintText: 'Search City',
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 17,
                  fontWeight: FontWeight.normal,
                ),
              ),
              controller: _searchController,
              autofocus: true,
              textInputAction: TextInputAction.search,
              keyboardType: TextInputType.text,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),
              ],
              validator: (value) {
                if (value!.isEmpty) return 'Enter valid city name';
                return null;
              },
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  /// Function to call api[Search]
  void _search() async{
    if(!mounted) return;
    setState(() => _showSpinner = true);
    String city = _searchController.text;
    var api = UserDataSource();
    await api.getCityWeatherData(city).then((WeatherData value) {
      if(!mounted) return;
      setState(() {
        _showSpinner = false;
        weatherData = value;
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  CustomSearchPage(weatherModel: weatherData,)),
      );
    }).catchError((e) {
      if(!mounted) return;
      setState(() => _showSpinner = false);
      Functions.showMessage('$e or check the name of the city and try again');
    });
  }

}
