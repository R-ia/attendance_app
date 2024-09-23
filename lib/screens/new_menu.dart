import 'dart:async'; // Importing dart:async for Completer
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:attendance_app/services/auth_services.dart';
import 'login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/person.dart'; // Import your Person model
import '../utils/constants.dart'; // Import constants for persons
import 'attendance.dart';

class MenuScreen extends StatefulWidget {
  final LatLng? userLocation; // Make userLocation optional

  // Constructor to accept optional user location
  MenuScreen({Key? key, this.userLocation}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final AuthService _authService = AuthService();
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _loadMarkers(); // Load markers on initialization
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser = _authService.getCurrentUser();

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
                if (widget.userLocation != null) {
                  // Center the map on the user's location
                  controller.animateCamera(CameraUpdate.newLatLng(widget.userLocation!));
                } else {
                  // Optionally center on the first member's location or a default location
                  controller.animateCamera(CameraUpdate.newLatLng(
                    persons.isNotEmpty ? persons[0].locations[0] : LatLng(29.38, 79.53),
                  ));
                }
              },
              initialCameraPosition: CameraPosition(
                target: widget.userLocation ?? LatLng(29.38, 79.53), // Default to first member if no userLocation
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
                    foregroundColor:
                        Color.fromARGB(255, 106, 13, 182), // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30), // Rounded corners
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

  // Load markers for all members or the selected user's location
  void _loadMarkers() {
    _markers.clear(); // Clear existing markers
    if (widget.userLocation != null) {
      // Add only the selected user's marker
      _markers.add(
        Marker(
          markerId: MarkerId('selectedUser'), // Unique ID for the selected user
          position: widget.userLocation!, // Use the passed user location
          infoWindow: InfoWindow(
            title: 'User Location',
            snippet: 'Location of selected user',
          ),
        ),
      );
    } else {
      // Add markers for all members
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
}
