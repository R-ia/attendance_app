import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';

class RouteDetails {
  final List<LatLng> points;
  final String distance;
  final String duration;

  RouteDetails(
      {required this.points, required this.distance, required this.duration});
}

Future<RouteDetails> fetchRoute(LatLng start, LatLng end) async {
  final String apiKey =
      'AIzaSyA7VRrJc0nxBoH2WhemLcwhEqQnUCPfcTA'; // Replace with your actual API key
  final String url =
      'https://maps.googleapis.com/maps/api/directions/json?origin=${start.latitude},${start.longitude}&destination=${end.latitude},${end.longitude}&key=$apiKey';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    if (data['routes'].isNotEmpty) {
      final List<LatLng> points = [];
      for (var step in data['routes'][0]['legs'][0]['steps']) {
        final latLng = step['end_location'];
        points.add(LatLng(latLng['lat'], latLng['lng']));
      }

      // Get distance and duration
      String distance = data['routes'][0]['legs'][0]['distance']['text'];
      String duration = data['routes'][0]['legs'][0]['duration']['text'];

      return RouteDetails(
          points: points, distance: distance, duration: duration);
    }
  }
  throw Exception('Failed to load route');
}
