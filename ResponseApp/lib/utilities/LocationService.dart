import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

class LocationService {
  String _userLocation = 'INDIA';
  double latitude;
  double longitude;

  Future<String> getLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);

      final coordinates = Coordinates(position.latitude, position.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);

      var first = addresses.first;

      var country = first.countryName;
      var adminArea = first.adminArea;
      var subAdminArea = first.subAdminArea;
      var locality = first.locality;
      var subLocality = first.subLocality;

      _userLocation = country +
          ' ' +
          adminArea +
          ' ' +
          subAdminArea +
          ' ' +
          locality +
          ' ' +
          subLocality;
      _userLocation = _userLocation.toString().toUpperCase();

      return _userLocation;
    } catch (e) {
      print('$e       : occurred in LocationService.dart');
      return _userLocation;
    }
  }

  Future<double> getLat() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

      return position.latitude;
    } catch (e) {
      return 20.5937;
    }
  }

  Future<double> getLong() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

      return position.longitude;
    } catch (e) {
      print(e);

      return 78.9629;
    }
  }
}
