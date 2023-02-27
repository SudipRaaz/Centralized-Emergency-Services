import 'package:ems_project/resource/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  GoogleMapController? _controller;
  final List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();

    // Add markers for vehicles to the list of markers
    _markers.add(
      Marker(
        markerId: const MarkerId('vehicle1'),
        position: const LatLng(27.689875, 85.319178),
        infoWindow: const InfoWindow(
          title: 'Vehicle 1',
          snippet: 'Vehicle Type: Sedan',
        ),
        onTap: () {
          // Show further details about the vehicle when tapped
        },
      ),
    );

    _markers.add(
      Marker(
        markerId: const MarkerId('vehicle2'),
        position: const LatLng(27.694258, 85.311030),
        infoWindow: const InfoWindow(
          title: 'Vehicle 2',
          snippet: 'Vehicle Type: SUV',
        ),
        onTap: () {
          // Show further details about the vehicle when tapped
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ambulance Services'),
        backgroundColor: AppColors.appBar_theme,
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        initialCameraPosition: const CameraPosition(
          target: LatLng(27.689875, 85.319178),
          zoom: 14.0,
        ),
        markers: Set.from(_markers),
      ),
    );
  }
}
