import 'package:attendance_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:attendance_app/assets/fake_users.dart';

class LiveLocationScreen extends StatefulWidget {
  final int memberId;

  const LiveLocationScreen({super.key, required this.memberId});

  @override
  _LiveLocationScreen createState() => _LiveLocationScreen();
}

class _LiveLocationScreen extends State<LiveLocationScreen> {
  late GoogleMapController mapController;

  // List of members with their current locations
  final List<Map<String, dynamic>> members = MockData.getFakeMembers();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    // Find the member by ID
    final member = members.firstWhere((m) => m['id'] == widget.memberId);

    final currentLatitude = member['currentLocation']['latitude'];
    final currentLongitude = member['currentLocation']['longitude'];
    final currentLocationName = member['currentLocationName'];

    Set<Marker> memberMarkers = {
      Marker(
        markerId: MarkerId(member['id'].toString()),
        position: LatLng(currentLatitude, currentLongitude),
        infoWindow: InfoWindow(
          title: member['name'],
          snippet: member['email'],
        ),
      ),
    };

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Live Location',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.background,
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                currentLatitude,
                currentLongitude,
              ),
              zoom: 16.0,
            ),
            markers: memberMarkers,
            zoomControlsEnabled: true,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Member Name
                  Text(
                    member['name'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8.0),

                  // Member Email
                  Row(
                    children: [
                      Icon(Icons.email, color: Colors.grey[600], size: 20),
                      const SizedBox(width: 8),
                      Text(
                        member['email'],
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),

                  Divider(
                    height: 20,
                    color: Colors.grey[300],
                    thickness: 1,
                  ),

                  // Current Location Label
                  const Text(
                    'Current Location:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 4.0),

                  // Current Location Name
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          color: AppColors.purple, size: 22),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          currentLocationName,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                          overflow: TextOverflow.ellipsis, // Handle long names
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
