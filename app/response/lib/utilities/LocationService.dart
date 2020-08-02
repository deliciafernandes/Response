import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

class LocationService {
  bool _match = false;
  String _userLocation = 'INDIA';

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

      return _userLocation;
    } catch (e) {
      print('$e       : occurred in LocationService.dart');
      return _userLocation;
    }
  }

  bool checkIfUserLocationAndNewsLocationMatch(String newsLocation) {
    getLocation();
    _match = _userLocation.toUpperCase().contains(newsLocation);

    return _match;
  }
}
