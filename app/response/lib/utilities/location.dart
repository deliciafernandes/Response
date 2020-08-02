import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

class Location {
  bool match;

  Future<bool> checkMatch(String _newsLocation) async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      final coordinates = Coordinates(position.latitude, position.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;

      var country = first.countryName;
      var adminArea = first.adminArea;
      var subAdminArea = first.subAdminArea;
      var locality = first.locality;
      var subLocality = first.subLocality;

      String _userLocation = country +
          ' ' +
          adminArea +
          ' ' +
          subAdminArea +
          ' ' +
          locality +
          ' ' +
          subLocality;

      match = _userLocation.toUpperCase().contains(_newsLocation);

      return match;
    } catch (e) {
      match = false;

      return match;
      print('$e       : occurred in location.dart');
    }
  }
}
