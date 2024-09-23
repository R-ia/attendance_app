// member_screen.dart
import 'package:flutter/material.dart';
import '../utils/constants.dart'; // Import constants
import 'person_details_screen.dart';
import '../models/person.dart'; // Import the Person model

class MemberScreen extends StatefulWidget {
  @override
  _MemberScreenState createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  List<Person> filteredList = persons; // Initialize with the full list

  void _filterMembers(String query) {
    final filtered = persons.where((person) {
      return person.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredList = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Members'),
        backgroundColor: Color.fromARGB(255, 106, 13, 182),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterMembers,
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: filteredList.isNotEmpty
                ? ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final person = filteredList[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(person.imagePath),
                        ),
                        title: Text(person.name),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PersonDetailsScreen(person: person),
                            ),
                          );
                        },
                      );
                    },
                  )
                : Center(
                    child: Text('No results found'),
                  ),
          ),
        ],
      ),
    );
  }
}
