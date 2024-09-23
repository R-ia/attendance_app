import 'package:attendance_app/assets/fake_users.dart';
import 'package:attendance_app/screens/map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendance_app/screens/attendance.dart';
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
        title: Text(
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
                  style: TextStyle(color: AppColors.textColor)),
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
      body: ListView.builder(
        itemCount: members.length,
        itemBuilder: (context, index) {
          final member = members[index];
          return CustomizedTile(
            name: member['name'],
            email: member['email'],
            onCalendarTap: () {
              // Handle calendar icon tap
            },
            onLocationTap: () {
              // Pass the member ID to MapScreen
              Get.to(() => MapScreen(memberId: member['id']));
            },
            onTap: () {
              // Handle member tap
            },
          );
        },
      ),
    );
  }
}
