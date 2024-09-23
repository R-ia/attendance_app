import 'package:attendance_app/assets/fake_users.dart';
import 'package:attendance_app/screens/map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendance_app/screens/attendance.dart';
import 'package:attendance_app/services/auth_services.dart';
import 'login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:attendance_app/utils/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import '../models/person.dart'; // Import your Person model

class MenuScreen extends StatelessWidget {
  final AuthService _authService = AuthService();
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    User? currentUser = _authService.getCurrentUser();

    // Load markers from persons' locations
    _loadMarkers();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ATTENDANCE',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF161926),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.person, // Replace with your desired icon
                    size: 40,
                    color: Colors.white,
                  ),
                  SizedBox(height: 8), // Space between icon and text
                  Text(
                    currentUser?.displayName ?? "User",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  SizedBox(height: 4),
                  Text(
                    currentUser?.email ?? "",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: AppColors.background,
              ),
            ),
            ListTile(
              title: Text('Attendance',
                  style: TextStyle(color: const Color(0xFF000000))),
              onTap: () {
                // Navigate to Attendance Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AttendanceScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: AppColors.errorColor,
              ),
              title: Text('Sign Out',
                  style: TextStyle(color: AppColors.textColor)),
              onTap: () async {
                await _authService.signOut();
                Get.offAll(LoginScreen());
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                // Load markers when map is created
                _loadMarkers();
              },
              initialCameraPosition: const CameraPosition(
                target: LatLng(29.38, 79.53), // Initial map center
                zoom: 15,
              ),
              markers: _markers,
            ),
          ),
          Container(
            color: Color(0xFF161926), // Bottom bar color
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'List View',
                  style: TextStyle(
                    fontSize: 18, // Set your desired font size
                    fontWeight: FontWeight.bold, // Make text bold
                    color: Colors.white,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.to(AttendanceScreen()); // Navigate to AttendanceScreen
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    backgroundColor: Colors.white, // Button color
                    foregroundColor: Color.fromARGB(255, 106, 13, 182), // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Rounded corners
                    ),
                    elevation: 5, // Adding elevation for depth
                  ),
                  child: const Text("Show List View"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Load markers from persons' locations
  void _loadMarkers() {
    _markers.clear(); // Clear existing markers
    for (var person in persons) {
      if (person.locations.isNotEmpty) {
        var location = person.locations[0]; // Use the first location
        _markers.add(
          Marker(
            markerId: MarkerId(person.name), // Use name as marker ID
            position: location,
            infoWindow: InfoWindow(
              title: person.name,
              snippet: 'Location',
            ),
          ),
        );
      }
    }
  }
}
