import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:softprism/model/forecast_weather_model.dart';
import 'package:softprism/model/weather_model.dart';
import 'package:softprism/networking/user_data_source.dart';

class FutureValues {

  /// Function that gets weather data based on the users location
  Future<WeatherData> getUserData() async{
    var data = UserDataSource();
    Future<WeatherData> weather = data.getUserWeatherData();
    return weather;
  }

  /// Function to get history of weather description from the database [file]
  Future<void> getDescriptionHistory() async{
    var dir = await getTemporaryDirectory();
    var myFile = File(dir.path + '/' + 'weather.json');
    await myFile.open();
    myFile.openRead();
  }

  ///Function that gets future forecast weather data based on the users location
  Future<ForecastWeatherData> getUserForecastData() async{
    var data = UserDataSource();
    Future<ForecastWeatherData> weatherForecast = data.getWeatherFutureForecastData();
    return weatherForecast;
  }

}