import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../../core/enums.dart';
import '../../../../services/location_service.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../opportunity/presentation/bloc/opportunity_bloc.dart';

class GoogleMapPage extends StatelessWidget {
  GoogleMapPage({super.key});

  GoogleMapController? _controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        return BlocBuilder<OpportunityBloc, OpportunityState>(
          builder: (context, state) {
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
                          BlocProvider.of<OpportunityBloc>(context).add(
                            UpdateTempLocation(
                              state: state,
                              location: position,
                            ),
                          );
                        },
                        markers: state.selectedLocation != null
                            ? {
                                Marker(
                                  markerId: const MarkerId('selected-location'),
                                  position: state.selectedLocation!,
                                ),
                              }
                            : {},
                      ),
                      if (state.address != null)
                        Positioned(
                          bottom: 80,
                          left: 20,
                          right: 20,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                state.address!,
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
              floatingActionButton: state.selectedLocation != null
                  ? FloatingActionButton(
                      child: const Icon(Icons.check),
                      onPressed: () {
                        BlocProvider.of<AuthBloc>(context).add(
                          ChangePageEvent(
                            state: authState,
                            changePage: CurrentPage.postOpportunity,
                          ),
                        );
                      },
                    )
                  : null,
            );
          },
        );
      },
    );
  }
}
