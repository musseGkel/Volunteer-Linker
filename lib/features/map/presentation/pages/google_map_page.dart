import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart';

import '../../../../services/location_service.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key});

  @override
  _GoogleMapPageState createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  GoogleMapController? _controller;
  LatLng? _selectedLocation;
  String? _address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Location')),
      body: FutureBuilder<LocationData?>(
        future: LocationService().getCurrentLocation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('Error getting location'));
          }

          LocationData? locationData = snapshot.data;
          LatLng initialLocation =
              LatLng(locationData!.latitude!, locationData.longitude!);

          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: initialLocation,
                  zoom: 15,
                ),
                onMapCreated: (controller) {
                  _controller = controller;
                },
                onTap: (position) async {
                  setState(() {
                    _selectedLocation = position;
                    print("Selected Location: $_selectedLocation");
                  });
                  List<Placemark> placemarks = await placemarkFromCoordinates(
                      position.latitude, position.longitude);
                  if (placemarks.isNotEmpty) {
                    Placemark placemark = placemarks.first;
                    setState(() {
                      _address =
                          "${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}";
                    });
                  }
                },
                markers: _selectedLocation != null
                    ? {
                        Marker(
                          markerId: const MarkerId('selected-location'),
                          position: _selectedLocation!,
                        ),
                      }
                    : {},
              ),
              if (_address != null)
                Positioned(
                  bottom: 80,
                  left: 20,
                  right: 20,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        _address!,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
      floatingActionButton: _selectedLocation != null
          ? FloatingActionButton(
              child: const Icon(Icons.check),
              onPressed: () {
                Navigator.of(context).pop(_selectedLocation);
              },
            )
          : null,
    );
  }
}
