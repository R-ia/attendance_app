import 'package:flutter/material.dart';

class RouteScreen extends StatelessWidget {
  final Member member;

  RouteScreen({required this.member});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${member.name} - Route Traveled'),
      ),
      body: Center(
        child: Text('Displaying route traveled for ${member.name}'),
        // Integrate with Google Maps or another service to display the route.
      ),
    );
  }
}
