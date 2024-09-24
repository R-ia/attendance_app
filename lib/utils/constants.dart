import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/person.dart';

class AppColors {
  static const Color background = Color(0xFF161926);
  static const Color containerBackground = Colors.white;
  static const Color textColor = Colors.black;
  static const Color purple = Color(0xFF6229EE);
  static const Color hintTextColor = Colors.black54;
  static const Color errorColor = Colors.redAccent;
}

// Constants for persons and their locations
final List<Person> persons = [
  Person(
    name: 'Elon Musk',
    imagePath: 'assets/icons/elon.webp',
    locations: [
      LatLng(29.3807301, 79.5234928),
      LatLng(29.3707301, 79.5434928),
      LatLng(29.3807301, 79.5234928),
      // Add more LatLng points as needed
    ],
    status:"working",
    loginTime:"9:15",
    logoutTime:"",
  ),
  Person(
    name: 'Mark Jukar Barg',
    imagePath: 'assets/icons/mark.jpeg',
    locations: [
      LatLng(29.3744600, 79.5306311),
      // Add more LatLng points as needed
    ],
    status:"working",
    loginTime:"9:15",
    logoutTime:"",
  ),
  Person(
    name: 'Warren Buffet',
    imagePath: 'assets/icons/warren.webp',
    locations: [
      LatLng(29.3776651, 79.5283670),
      // Add more LatLng points as needed
    ],
    status:"",
    loginTime:"11:15",
    logoutTime:"4:50",
  ),
  Person(
    name: 'Ratan Naval Tata',
    imagePath: 'assets/icons/ratan.webp',
    locations: [
      LatLng(29.373965, 79.525962),
      // Add more LatLng points as needed
    ],
    status:"",
    loginTime:"9:15",
    logoutTime:"5:15",
  ),
  // Add more Person instances as needed
];
