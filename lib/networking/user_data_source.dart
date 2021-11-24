import 'package:softprism/location/location.dart';
import 'package:softprism/model/forecast_weather_model.dart';
import 'package:softprism/model/weather_model.dart';
import 'endpoints.dart';
import 'error_handler.dart';
import 'network_util.dart';

class UserDataSource {

  /// Instantiating a class of the [ErrorHandler]
  var errorHandler = ErrorHandler();

  /// Instantiating a class of the [NetworkHelper]
  var _netUtil = NetworkHelper();

  /// Instantiating a class of the [LocationHelper]
  var location = LocationHelper();

  ///A Function that gets weather using the users location
  /// It returns a [WeatherData] model
  Future<WeatherData> getUserWeatherData () async {
    await location.getLocation();
    String lat = (location.lat).toString();
    String long = (location.long).toString();
    return _netUtil.get(GET_WEATHER_DATA + 'lat=$lat&lon=$long' + API_KEY).then((res) {
      return WeatherData.fromJson(res);
    }).catchError((e){
      errorHandler.handleError(e);
    });
  }

  /// A function that gets the location weather details based on city name
  /// It returns a [WeatherData] model
  Future<WeatherData> getCityWeatherData(String city) async {
    return _netUtil.get(GET_CUSTOM_LOCATION_DATA + city + API_KEY).then((res) {
      return WeatherData.fromJson(res);
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  ///A Function that gets future weather forecast using the users location
  /// It returns a [ForecastWeatherData] model
  Future<ForecastWeatherData> getWeatherFutureForecastData () async {
    await location.getLocation();
    String lat = (location.lat).toString();
    String long = (location.long).toString();
    return _netUtil.get(GET_FUTURE_FORECASRT + 'lat=$lat&lon=$long' + API_KEY).then((res) {
      return ForecastWeatherData.fromJson(res);
    }).catchError((e){
      errorHandler.handleError(e);
    });
  }
}