import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';

class RouteDetails {
  final List<LatLng> points;
  final String distance; // In kilometers
  final String duration; // In a readable format

  RouteDetails(
      {required this.points, required this.distance, required this.duration});
}

Future<RouteDetails> fetchRoute(LatLng start, LatLng end) async {
  const String apiKey = 'AIzaSyA7VRrJc0nxBoH2WhemLcwhEqQnUCPfcTA';
  final String url =
      'https://maps.googleapis.com/maps/api/directions/json?origin=${start.latitude},${start.longitude}&destination=${end.latitude},${end.longitude}&key=$apiKey';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    if (data['routes'].isNotEmpty) {
      final List<LatLng> points = [];
      final leg = data['routes'][0]['legs'][0];

      String distanceText = leg['distance']['text'];
      String duration = leg['duration']['text'];

      double distanceInKm;
      if (distanceText.contains("mi")) {
        final distanceInMiles = double.parse(distanceText.split(" ")[0]);
        distanceInKm = distanceInMiles * 1.60934; // Convert miles to kilometers
      } else {
        distanceInKm = double.parse(distanceText.split(" ")[0]);
      }

      final formattedDistance =
          "${distanceInKm.toStringAsFixed(1)} km"; // Format to 1 decimal place

      for (var step in leg['steps']) {
        final latLng = step['end_location'];
        points.add(LatLng(latLng['lat'], latLng['lng']));
      }

      return RouteDetails(
          points: points, distance: formattedDistance, duration: duration);
    }
  }
  throw Exception('Failed to load route');
}
