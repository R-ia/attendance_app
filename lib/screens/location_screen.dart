import 'package:flutter/material.dart';

class LocationScreen extends StatelessWidget {
  final Member member;

  LocationScreen({required this.member});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${member.name} - Current Location'),
      ),
      body: Center(
        child: Text('Displaying current location for ${member.name}'),
        // Here you will integrate with platform-specific code
        // to get the current location using Android's location services.
      ),
    );
  }
}
