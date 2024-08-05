import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';
import 'package:volunteer_linker/constants/other_constants.dart';

import '../../../../services/location_service.dart';

class NavigationPage extends StatefulWidget {
  final LatLng destination;

  const NavigationPage({super.key, required this.destination});

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  GoogleMapController? _controller;
  final List<LatLng> _polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleMapApiKey = OtherConstants.googleMapApiKey;
  LocationService locationService = LocationService();
  LocationData? currentLocation;
  Stream<LocationData>? locationStream;

  @override
  void initState() {
    super.initState();
    _startLocationUpdates();
  }

  void _startLocationUpdates() async {
    locationStream = locationService.getLocationStream();
    locationStream?.listen((LocationData newLocation) async {
      currentLocation = newLocation;
      await _getPolyline();
    });
  }

  _getPolyline() async {
    if (currentLocation == null) return;

    double currentLatitude = //44.41986257967868;
        currentLocation!.latitude!;
    double currentLongitude = // 8.931168706847982;
        currentLocation!.longitude!;

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleMapApiKey,
      PointLatLng(currentLatitude, currentLongitude),
      PointLatLng(widget.destination.latitude, widget.destination.longitude),
    );

    if (result.points.isNotEmpty) {
      _polylineCoordinates.clear();
      for (var point in result.points) {
        _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }

      setState(() {});
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Navigate to Destination',
        ),
      ),
      body: currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    currentLocation!.latitude!, currentLocation!.longitude!),
                zoom: 15,
              ),
              onMapCreated: (controller) {
                _controller = controller;
              },
              polylines: _polylineCoordinates.isNotEmpty
                  ? {
                      Polyline(
                        polylineId: const PolylineId('route'),
                        points: _polylineCoordinates,
                        color: Colors.blue,
                        width: 5,
                      ),
                    }
                  : {},
              markers: {
                Marker(
                  markerId: const MarkerId('current-location'),
                  position: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueBlue),
                ),
                Marker(
                  markerId: const MarkerId('destination'),
                  position: widget.destination,
                ),
              },
            ),
    );
  }

  @override
  void dispose() {
    locationStream = null;
    super.dispose();
  }
}
