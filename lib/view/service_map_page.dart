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
        position: const LatLng(37.4219999, -122.0840575),
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
        markerId: MarkerId('vehicle2'),
        position: LatLng(37.4629101, -122.2449094),
        infoWindow: InfoWindow(
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
        title: Text('Ambulance Services'),
        backgroundColor: AppColors.appBar_theme,
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        initialCameraPosition: const CameraPosition(
          target: LatLng(37.42796133580664, -122.085749655962),
          zoom: 14.0,
        ),
        markers: Set.from(_markers),
      ),
    );
  }
}
