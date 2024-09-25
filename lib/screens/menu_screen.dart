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

  MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? currentUser = _authService.getCurrentUser();
    final members = MockData.getFakeMembers();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ATTENDANCE',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.background,
        iconTheme: const IconThemeData(color: Colors.white),
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
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    currentUser?.email ?? "",
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Attendance',
                  style: TextStyle(color: AppColors.textColor)),
              onTap: () {
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
                Get.offAll(const LoginScreen());
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
                Get.to(() =>
                    const MapViewScreen()); // Replace with your MapViewScreen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text(
                'Open Map View',
                style: TextStyle(color: AppColors.purple),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
