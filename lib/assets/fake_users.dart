class MockData {
  static List<Map<String, dynamic>> getFakeMembers() {
    return [
      {
        "id": 1,
        "name": "John Doe",
        "email": "john@example.com",
        "currentLocation": {
          "latitude": 34.0522, // Los Angeles, CA
          "longitude": -118.2437
        },
        "currentLocationName": "Los Angeles, CA", // Added current location name
        "visitedLocations": [
          {
            "location": "Los Angeles, CA",
            "coordinates": {"latitude": 34.0522, "longitude": -118.2437},
            "timestamp": "2024-09-20T10:00:00Z",
            "stopDuration": 30
          },
          {
            "location": "Santa Monica, CA",
            "coordinates": {"latitude": 34.0194, "longitude": -118.4912},
            "timestamp": "2024-09-20T11:00:00Z",
            "stopDuration": 45
          },
          {
            "location": "Hollywood, CA",
            "coordinates": {"latitude": 34.0928, "longitude": -118.3287},
            "timestamp": "2024-09-20T13:00:00Z",
            "stopDuration": 20
          },
          {
            "location": "Beverly Hills, CA",
            "coordinates": {"latitude": 34.0736, "longitude": -118.4053},
            "timestamp": "2024-09-20T14:30:00Z",
            "stopDuration": 35
          }
        ],
        "avatar": "https://randomuser.me/api/portraits/men/1.jpg"
      },
      {
        "id": 2,
        "name": "Jane Smith",
        "email": "jane@example.com",
        "currentLocation": {
          "latitude": 34.1400, // Farther north
          "longitude": -118.2500
        },
        "currentLocationName": "Los Angeles, CA", // Added current location name
        "visitedLocations": [
          {
            "location": "Los Angeles, CA",
            "coordinates": {"latitude": 34.1400, "longitude": -118.2500},
            "timestamp": "2024-09-21T09:00:00Z",
            "stopDuration": 15
          },
          {
            "location": "Long Beach, CA",
            "coordinates": {"latitude": 33.7701, "longitude": -118.1937},
            "timestamp": "2024-09-21T10:00:00Z",
            "stopDuration": 30
          },
          {
            "location": "Venice Beach, CA",
            "coordinates": {"latitude": 33.9850, "longitude": -118.4695},
            "timestamp": "2024-09-21T12:00:00Z",
            "stopDuration": 40
          },
          {
            "location": "Santa Monica, CA",
            "coordinates": {"latitude": 34.0194, "longitude": -118.4912},
            "timestamp": "2024-09-21T14:00:00Z",
            "stopDuration": 25
          }
        ],
        "avatar": "https://randomuser.me/api/portraits/women/1.jpg"
      },
      {
        "id": 3,
        "name": "Michael Johnson",
        "email": "michael@example.com",
        "currentLocation": {
          "latitude": 34.1000, // Farther east
          "longitude": -118.4000
        },
        "currentLocationName": "Hollywood, CA", // Added current location name
        "visitedLocations": [
          {
            "location": "Hollywood, CA",
            "coordinates": {"latitude": 34.0928, "longitude": -118.3287},
            "timestamp": "2024-09-22T08:00:00Z",
            "stopDuration": 20
          },
          {
            "location": "Beverly Hills, CA",
            "coordinates": {"latitude": 34.0736, "longitude": -118.4053},
            "timestamp": "2024-09-22T09:00:00Z",
            "stopDuration": 30
          },
          {
            "location": "Downtown LA, CA",
            "coordinates": {"latitude": 34.0407, "longitude": -118.2468},
            "timestamp": "2024-09-22T11:00:00Z",
            "stopDuration": 25
          },
          {
            "location": "Glendale, CA",
            "coordinates": {"latitude": 34.1425, "longitude": -118.2551},
            "timestamp": "2024-09-22T13:00:00Z",
            "stopDuration": 30
          }
        ],
        "avatar": "https://randomuser.me/api/portraits/men/2.jpg"
      },
      {
        "id": 4,
        "name": "Emily Davis",
        "email": "emily@example.com",
        "currentLocation": {
          "latitude": 34.2300, // Farther northeast
          "longitude": -118.5000
        },
        "currentLocationName": "Glendale, CA", // Added current location name
        "visitedLocations": [
          {
            "location": "Glendale, CA",
            "coordinates": {"latitude": 34.1425, "longitude": -118.2551},
            "timestamp": "2024-09-23T09:30:00Z",
            "stopDuration": 20
          },
          {
            "location": "Simi Valley, CA",
            "coordinates": {"latitude": 34.2694, "longitude": -118.7815},
            "timestamp": "2024-09-23T11:00:00Z",
            "stopDuration": 30
          },
          {
            "location": "Pasadena, CA",
            "coordinates": {"latitude": 34.1478, "longitude": -118.1445},
            "timestamp": "2024-09-23T13:30:00Z",
            "stopDuration": 25
          },
          {
            "location": "North Hollywood, CA",
            "coordinates": {"latitude": 34.1870, "longitude": -118.3813},
            "timestamp": "2024-09-23T15:00:00Z",
            "stopDuration": 40
          }
        ],
        "avatar": "https://randomuser.me/api/portraits/women/2.jpg"
      },
      {
        "id": 5,
        "name": "David Lee",
        "email": "david@example.com",
        "currentLocation": {
          "latitude": 34.0500, // Different area
          "longitude": -118.7000
        },
        "currentLocationName": "Downtown LA, CA", // Added current location name
        "visitedLocations": [
          {
            "location": "Downtown LA, CA",
            "coordinates": {"latitude": 34.0505, "longitude": -118.2551},
            "timestamp": "2024-09-24T09:00:00Z",
            "stopDuration": 30
          },
          {
            "location": "Ktown, CA",
            "coordinates": {"latitude": 34.0628, "longitude": -118.2500},
            "timestamp": "2024-09-24T10:30:00Z",
            "stopDuration": 45
          },
          {
            "location": "Santa Monica, CA",
            "coordinates": {"latitude": 34.0194, "longitude": -118.4912},
            "timestamp": "2024-09-24T13:00:00Z",
            "stopDuration": 35
          },
          {
            "location": "Hollywood, CA",
            "coordinates": {"latitude": 34.0928, "longitude": -118.3287},
            "timestamp": "2024-09-24T15:30:00Z",
            "stopDuration": 25
          }
        ],
        "avatar": "https://randomuser.me/api/portraits/men/3.jpg"
      },
      {
        "id": 6,
        "name": "Sophia Taylor",
        "email": "sophia@example.com",
        "currentLocation": {
          "latitude": 34.0505, // Farther south
          "longitude": -118.2505
        },
        "currentLocationName": "Downtown LA, CA", // Added current location name
        "visitedLocations": [
          {
            "location": "Echo Park, CA",
            "coordinates": {"latitude": 34.0134, "longitude": -118.2545},
            "timestamp": "2024-09-25T08:30:00Z",
            "stopDuration": 20
          },
          {
            "location": "Little Tokyo, CA",
            "coordinates": {"latitude": 34.0453, "longitude": -118.2400},
            "timestamp": "2024-09-25T09:30:00Z",
            "stopDuration": 30
          },
          {
            "location": "Chinatown, CA",
            "coordinates": {"latitude": 34.0630, "longitude": -118.2395},
            "timestamp": "2024-09-25T11:00:00Z",
            "stopDuration": 25
          },
          {
            "location": "LACMA, CA",
            "coordinates": {"latitude": 34.0622, "longitude": -118.3596},
            "timestamp": "2024-09-25T13:30:00Z",
            "stopDuration": 40
          }
        ],
        "avatar": "https://randomuser.me/api/portraits/women/3.jpg"
      }
    ];
  }
}
