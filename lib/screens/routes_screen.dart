import 'package:attendance_app/screens/fetch_routes.dart';
import 'package:attendance_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:attendance_app/assets/fake_users.dart';
import 'dart:math' as math;

class RouteScreen extends StatefulWidget {
  final int memberId;

  RouteScreen({required this.memberId});

  @override
  _RouteScreenState createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  late GoogleMapController mapController;
  Set<Marker> memberMarkers = {};
  Set<Polyline> polylines = {};
  String? currentPolylineId;

  String distance = '';
  String duration = '';

  void initState() {
    super.initState();
    // Set default values for distance and duration
    distance = '00 km';
    duration = '00 min';
  }

  final List<Map<String, dynamic>> members = MockData.getFakeMembers();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _showRoute(LatLng start, LatLng end) async {
    setState(() {
      memberMarkers.clear();
    });

    try {
      RouteDetails routeDetails = await fetchRoute(start, end);

      if (currentPolylineId != null) {
        setState(() {
          polylines.removeWhere(
              (polyline) => polyline.polylineId.value == currentPolylineId);
        });
      }

      final polylineId =
          'route_${start.latitude}_${start.longitude}_${end.latitude}_${end.longitude}';
      setState(() {
        polylines.add(
          Polyline(
            polylineId: PolylineId(polylineId),
            points: routeDetails.points,
            color: Colors.blue,
            width: 5,
          ),
        );
        currentPolylineId = polylineId;

        memberMarkers.add(
          Marker(
            markerId: MarkerId('start_${start.latitude}_${start.longitude}'),
            position: start,
            infoWindow: InfoWindow(title: 'Start', snippet: 'Starting point'),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          ),
        );

        memberMarkers.add(
          Marker(
            markerId: MarkerId('end_${end.latitude}_${end.longitude}'),
            position: end,
            infoWindow: InfoWindow(title: 'End', snippet: 'Ending point'),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          ),
        );

        // Update distance and duration
        distance = routeDetails.distance;
        duration = routeDetails.duration;
      });

      LatLngBounds bounds = LatLngBounds(
        southwest: LatLng(
          math.min(start.latitude, end.latitude),
          math.min(start.longitude, end.longitude),
        ),
        northeast: LatLng(
          math.max(start.latitude, end.latitude),
          math.max(start.longitude, end.longitude),
        ),
      );

      mapController.animateCamera(
        CameraUpdate.newLatLngBounds(bounds, 100),
      );
    } catch (e) {
      print('Error fetching route: $e');
    }
  }

  Widget _buildVisitedLocations() {
    final member = members.firstWhere((m) => m['id'] == widget.memberId);

    return DraggableScrollableSheet(
      initialChildSize: 0.3,
      minChildSize: 0.2,
      maxChildSize: 0.5,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5.0,
                spreadRadius: 2.0,
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  member['name'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: member['visitedLocations'].length,
                  itemBuilder: (context, index) {
                    final location = member['visitedLocations'][index];
                    final nextLocation =
                        index < member['visitedLocations'].length - 1
                            ? member['visitedLocations'][index + 1]
                            : null;

                    return ListTile(
                      leading: Icon(Icons.location_on, color: AppColors.purple),
                      title: Text(
                        location['location'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Visited on: ${location['timestamp']} \nStop Duration: ${location['stopDuration']} mins',
                      ),
                      trailing: nextLocation != null
                          ? IconButton(
                              icon: Icon(Icons.arrow_forward),
                              onPressed: () {
                                LatLng start = LatLng(
                                  location['coordinates']['latitude'],
                                  location['coordinates']['longitude'],
                                );
                                LatLng end = LatLng(
                                  nextLocation['coordinates']['latitude'],
                                  nextLocation['coordinates']['longitude'],
                                );
                                _showRoute(start, end);
                              },
                            )
                          : null,
                      onTap: () {},
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final member = members.firstWhere((m) => m['id'] == widget.memberId);

    if (polylines.isEmpty) {
      memberMarkers.add(
        Marker(
          markerId: MarkerId(member['id'].toString()),
          position: LatLng(
            member['currentLocation']['latitude'],
            member['currentLocation']['longitude'],
          ),
          infoWindow: InfoWindow(
            title: member['name'],
            snippet: member['email'],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Visited Routes',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.background,
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                member['currentLocation']['latitude'],
                member['currentLocation']['longitude'],
              ),
              zoom: 16.0,
            ),
            markers: memberMarkers,
            polylines: polylines,
            zoomControlsEnabled: true,
          ),
          _buildVisitedLocations(),
          Positioned(
            top: 60, // Adjust this position as needed
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white.withOpacity(0.8),
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text('Distance: $distance',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Duration: $duration',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
