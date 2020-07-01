import 'dart:convert';

import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'AIzaSyByMffNzSdPTN0Vbth7nhiLJt_SMMH5UHE';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitude, double longtitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longtitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longtitude&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAdress(double lat, double lng) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY';
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
