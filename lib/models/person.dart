// models/person.dart
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Person {
  final String name;
  final String imagePath;
  final List<LatLng> locations;
  final String status;
  final String loginTime;
  final String logoutTime;


  Person({required this.name, required this.imagePath, required this.locations,required this.status,required this.loginTime,required this.logoutTime});
}
