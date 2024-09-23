// models/person.dart
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Person {
  final String name;
  final String imagePath;
  final List<LatLng> locations;

  Person({required this.name, required this.imagePath, required this.locations});
}
