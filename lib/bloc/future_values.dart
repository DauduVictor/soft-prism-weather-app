
import 'package:softprism/networking/user_data_source.dart';

class FutureValues {

  /// Function that gets weather data based on the users location
  Future<dynamic> getUserData() async{
    var data = UserDataSource();
    Future<dynamic> weather = data.getUserWeatherData();
    return weather;
  }

}