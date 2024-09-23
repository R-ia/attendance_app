import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart'; // Added GetX for navigation
import '../models/person.dart'; // Ensure this is correctly imported
import '../utils/constants.dart'; // Ensure this is correctly imported
import 'new_menu.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Import LatLng

// Attendance screen to display a list of members
class AttendanceScreen extends StatelessWidget {
  final List<Member> members = persons.map((person) {
    return Member(
      name: person.name,
      id: person.name.replaceAll(" ", "").toUpperCase(),
      profileImage: person.imagePath,
      loginTime: '09:30 am', // Default login time
      logoutTime: '', // Default logout time (not logged out)
      status: 'Working', // Default status
      location: person.locations.isNotEmpty ? person.locations[0] : null, // Add location property
    );
  }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Attendance',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF161926),
        iconTheme: const IconThemeData(
          color: Colors.white, // Change back button color to white
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: members.length,
            itemBuilder: (context, index) {
              final member = members[index];
              return MemberTile(
                member: member,
                onLocationPressed: (LatLng location) {
                  Get.to(MenuScreen(userLocation: location)); // Navigate to MenuScreen with location
                },
              );
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: const Color(0xFF161926), // Bottom bar color
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Show Map View',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(MenuScreen()); // Navigate to MenuScreen without a specific location to show all users
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      backgroundColor: Colors.white, // Button color
                      foregroundColor:
                          const Color.fromARGB(255, 106, 13, 182), // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30), // Rounded corners
                      ),
                      elevation: 5, // Adding elevation for depth
                    ),
                    child: const Text("Show Map View"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// MemberTile widget to display member info in a list tile
class MemberTile extends StatelessWidget {
  final Member member;
  final Function(LatLng) onLocationPressed; // Callback for location icon

  const MemberTile({
    Key? key,
    required this.member,
    required this.onLocationPressed, // Add this line
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(member.profileImage),
        radius: 30,
      ),
      title: Text('${member.name} (${member.id})'),
      subtitle: Row(
        children: [
          Icon(Icons.arrow_upward, color: Colors.green, size: 16),
          SizedBox(width: 5),
          Text(member.loginTime),
          if (member.logoutTime.isNotEmpty) ...[
            SizedBox(width: 10),
            Icon(Icons.arrow_downward, color: Colors.red, size: 16),
            SizedBox(width: 5),
            Text(member.logoutTime),
          ]
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (member.status == 'Working')
            Transform.scale(
              scale: 0.8,
              child: Chip(
                label: Text(member.status),
                backgroundColor: Colors.green,
              ),
            ),
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/history.svg',
              width: 24,
              height: 24,
            ),
            onPressed: () {
              // Add history viewing functionality
            },
          ),
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/location.svg',
              width: 24,
              height: 24,
            ),
            onPressed: () {
              if (member.location != null) { // Check for null before calling
                onLocationPressed(member.location!); // Use the location
              } else {
                // Optionally show a message that location is not available
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Location not available')),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

// Member model to represent a member's details
class Member {
  final String name;
  final String id;
  final String profileImage;
  final String loginTime;
  final String logoutTime;
  final String status;
  final LatLng? location; // Add location property

  Member({
    required this.name,
    required this.id,
    required this.profileImage,
    required this.loginTime,
    required this.logoutTime,
    required this.status,
    this.location, // Include in the constructor
  });
}
