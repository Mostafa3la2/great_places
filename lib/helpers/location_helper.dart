import 'package:http/http.dart' as http;
import 'dart:convert';

const GOOGLE_API_KEY = "INSERT_YOUR_API_KEY";

class LocationHelper {
  static String generateLocationPreviewImage(
      {required double lat, required double long}) {
    return "https://maps.googleapis.com/maps/api/staticmap?center=&$lat,$long&zoom=13&size=600x300&maptype=roadmap&markers=color:purple%7Clabel:M%7C$lat,$long&key=$GOOGLE_API_KEY";
  }

  static Future<String> getPlaceAddress(double lat, double long) async {
    var urlString =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=$GOOGLE_API_KEY";
    var url = Uri.parse(urlString);
    final response = await http.get(url);
    return json.decode(response.body)["results"][0]["formatted_address"];
  }
}
