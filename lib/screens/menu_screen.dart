import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendance_app/screens/attendance.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance App'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Attendance'),
              onTap: () {
                // Navigate to Attendance Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AttendanceScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Locations'),
              onTap: () {
                // Navigate to Locations Screen
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Welcome to Attendance App!'),
      ),
    );
  }
}
