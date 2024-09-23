import 'package:flutter/material.dart';
import '../models/person.dart';
import '../utils/constants.dart'; // Ensure to import your constants

class ListViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Members List'),
        backgroundColor: const Color(0xFF161926),
      ),
      body: ListView.builder(
        itemCount: persons.length,
        itemBuilder: (context, index) {
          final person = persons[index];
          return ListTile(
            title: Text(person.name),
            subtitle: Text('Location: ${person.locations[0]}'), // Displaying the first location
            leading: CircleAvatar(
              backgroundImage: AssetImage(person.imagePath), // Assuming image path is valid
            ),
          );
        },
      ),
    );
  }
}
