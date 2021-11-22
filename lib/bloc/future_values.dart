import 'package:softprism/model/weather_model.dart';
import 'package:softprism/networking/user_data_source.dart';

class FutureValues {

  /// Function that gets weather data based on the users location
  Future<WeatherData> getUserData() async{
    var data = UserDataSource();
    Future<WeatherData> weather = data.getUserWeatherData();
    return weather;
  }

  /// Function that gets in depth location details based on the long and lat of the user



}