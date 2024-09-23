class MockData {
  static List<Map<String, dynamic>> getFakeMembers() {
    return [
      {
        "id": 1,
        "name": "John Doe",
        "email": "john@example.com",
        "currentLocation": {
          "latitude":
              40.730610, // Example coordinates for John's current location
          "longitude": -73.935242
        },
        "visitedLocations": [
          {
            "location": "New York, NY",
            "coordinates": {"latitude": 40.7128, "longitude": -74.0060},
            "timestamp": "2024-09-20T10:00:00Z",
            "stopDuration": 15 // Duration in minutes
          },
          {
            "location": "Boston, MA",
            "coordinates": {"latitude": 42.3601, "longitude": -71.0589},
            "timestamp": "2024-09-19T12:00:00Z",
            "stopDuration": 30 // Duration in minutes
          }
        ]
      },
      {
        "id": 2,
        "name": "Jane Smith",
        "email": "jane@example.com",
        "currentLocation": {
          "latitude":
              37.804363, // Example coordinates for Jane's current location
          "longitude": -122.271111
        },
        "visitedLocations": [
          {
            "location": "San Francisco, CA",
            "coordinates": {"latitude": 37.7749, "longitude": -122.4194},
            "timestamp": "2024-09-20T09:00:00Z",
            "stopDuration": 10 // Duration in minutes
          },
          {
            "location": "Los Angeles, CA",
            "coordinates": {"latitude": 34.0522, "longitude": -118.2437},
            "timestamp": "2024-09-18T15:00:00Z",
            "stopDuration": 20 // Duration in minutes
          }
        ]
      }
    ];
  }
}
