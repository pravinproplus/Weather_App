import 'package:geolocator/geolocator.dart';

class LocationGet {
  Position? position;
  double? latitude;
  double? longtitude;
  Future<void> getLocationData() async {
    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      latitude = position!.latitude;
      longtitude = position!.longitude;
      print(position);
    } catch (e) {
      print(e);
    }
  }
}
