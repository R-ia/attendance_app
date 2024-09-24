import 'package:attendance_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:attendance_app/assets/fake_users.dart';
import 'package:get/get.dart';
import 'package:attendance_app/screens/menu_screen.dart';

class MapViewScreen extends StatefulWidget {
  @override
  _MapViewScreenState createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _createMarkers();
  }

  void _createMarkers() {
    final members = MockData.getFakeMembers();
    for (var member in members) {
      final location = member['currentLocation'];
      _markers.add(
        Marker(
          markerId: MarkerId(member['id'].toString()),
          position: LatLng(location['latitude'], location['longitude']),
          infoWindow: InfoWindow(
            title: member['name'],
            snippet: member['email'],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        shadowColor: Colors.white,
        title: const Text(
          'Map View',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.background,
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(34.0522, -118.2437), // Center on Los Angeles
                zoom: 10,
              ),
              markers: _markers,
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Navigate to the MenuScreen using GetX
                Get.to(() => MenuScreen());
              },
              child: const Text(
                'List View',
                style: TextStyle(color: AppColors.purple),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
