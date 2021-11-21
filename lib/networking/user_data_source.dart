import 'package:softprism/location/location.dart';
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
  /// It returns a (dynamic response)
  Future<WeatherData> getUserWeatherData () async {
    String _apiKey = '&appid=878cdcf72b30095858a2328f9fcc6e72&units=metric';
    await location.getLocation();
    String lat = (location.lat).toString();
    String long = (location.long).toString();
    return _netUtil.get(GET_WEATHER_DATA + 'lat=$lat&lon=$long' + _apiKey).then((res) {
      print(res);
      return WeatherData.fromJson(res);
    }).catchError((e){
      print(e);
      errorHandler.handleError(e);
    });
  }
}