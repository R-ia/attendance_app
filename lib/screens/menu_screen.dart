import 'package:attendance_app/assets/fake_users.dart';
import 'package:attendance_app/screens/live_location_screen.dart';
import 'package:attendance_app/screens/map_view_screen.dart';
import 'package:attendance_app/screens/routes_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendance_app/services/auth_services.dart';
import 'login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:attendance_app/utils/constants.dart';
import 'package:attendance_app/custom/customized_tiles.dart';

class MenuScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    User? currentUser = _authService.getCurrentUser();
    final members = MockData.getFakeMembers(); // Access mock data directly

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ATTENDANCE',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.background,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: AppColors.background,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    currentUser?.displayName ?? "User",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    currentUser?.email ?? "",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Attendance',
                  style: TextStyle(color: AppColors.textColor)),
              onTap: () {
                // Navigate to Attendance Screen
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: AppColors.errorColor,
              ),
              title: const Text('Sign Out',
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
            child: ListView.builder(
              itemCount: members.length,
              itemBuilder: (context, index) {
                final member = members[index];
                return CustomizedTile(
                  name: member['name'],
                  email: member['email'],
                  avatarUrl: member['avatar'],
                  onCalendarTap: () {
                    Get.to(() => RouteScreen(memberId: member['id']));

                    // Handle calendar icon tap
                  },
                  onLocationTap: () {
                    Get.to(() => LiveLocationScreen(memberId: member['id']));
                  },
                  onTap: () {
                    // Handle member tap
                  },
                );
              },
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Navigate to the map view
                Get.to(
                    () => MapViewScreen()); // Replace with your MapViewScreen
              },
              child: const Text(
                'Open Map View',
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
          const SizedBox(height: 20), // Add some space below the button
        ],
      ),
    );
  }
}
