import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:attendance_app/assets/fake_users.dart';

class MapScreen extends StatefulWidget {
  final int memberId;

  MapScreen({required this.memberId}); // Accept memberId in the constructor

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(37.42796133238185, -122.0857496557668);

  // List of members with their current locations
  final List<Map<String, dynamic>> members = MockData.getFakeMembers();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    // Find the member by ID
    final member = members.firstWhere((m) => m['id'] == widget.memberId);

    // Create markers for the member's current location
    Set<Marker> memberMarkers = {
      Marker(
        markerId: MarkerId(member['id'].toString()),
        position: LatLng(
          member['currentLocation']['latitude'],
          member['currentLocation']['longitude'],
        ),
        infoWindow: InfoWindow(
          title: member['name'],
          snippet: member['email'],
        ),
      ),
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Members Map'),
      ),
      body: Column(
        children: [
          // Google Map section
          Container(
            height: 300, // Height of the map
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  member['currentLocation']['latitude'],
                  member['currentLocation']['longitude'],
                ),
                zoom: 10.0, // Zoom level focused on the member's location
              ),
              markers: memberMarkers,
            ),
          ),
          // List of visited locations
          Expanded(
            child: ListView.builder(
              itemCount: member['visitedLocations'].length,
              itemBuilder: (context, index) {
                final location = member['visitedLocations'][index];
                return ListTile(
                  title: Text(location['location']),
                  subtitle: Text(
                    '${location['timestamp']} (${location['stopDuration']} mins)',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
