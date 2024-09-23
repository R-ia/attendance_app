// person_details_screen.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/person.dart';

class PersonDetailsScreen extends StatelessWidget {
  final Person person;

  PersonDetailsScreen({required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${person.name}\'s History'),
        backgroundColor: Color.fromARGB(255, 106, 13, 182),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Location History', style: TextStyle(fontSize: 18)),
          ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: person.locations.isNotEmpty ? person.locations.first : LatLng(0, 0),
                zoom: 12,
              ),
              markers: person.locations.map((location) {
                return Marker(
                  markerId: MarkerId(location.toString()),
                  position: location,
                  infoWindow: InfoWindow(title: location.toString()),
                );
              }).toSet(),
            ),
          ),
        ],
      ),
    );
  }
}
