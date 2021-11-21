import 'package:geolocator/geolocator.dart';
import 'package:softprism/utils/functions.dart';

class LocationHelper {

  double? lat;
  double? long;

  ///function to get the users location based on their gps locator
  Future<void> getLocation()  async {
    try{
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      lat = position.latitude;
      long = position.longitude;
    }catch(e){
      Functions.showMessage('Please enable your location and try again');
    }
  }

}