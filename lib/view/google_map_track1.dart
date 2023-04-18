import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyMapTrack1 extends StatefulWidget {
  final GeoPoint userLocation;
  final String? staffID1;
  const MyMapTrack1({
    super.key,
    required this.userLocation,
    this.staffID1,
  });

  @override
  // ignore: library_private_types_in_public_api
  _MyMapTrack1State createState() => _MyMapTrack1State();
}

class _MyMapTrack1State extends State<MyMapTrack1> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // list of staff data
    List staff1Location = [];

    // markers
    List<Marker> markers = [];

    final Stream<QuerySnapshot> staff1 = FirebaseFirestore.instance
        .collection('Staffs')
        .where('UID', isEqualTo: widget.staffID1)
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: staff1,
        builder: (context, snapshots) {
          staff1Location = [];
          //circular progress indicator
          if (!snapshots.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // converting JSON to list
          snapshots.data!.docs.map((DocumentSnapshot document) {
            Map staffData = document.data() as Map<String, dynamic>;
            staff1Location.add(staffData);
          }).toList();

          // pointing markers
          Marker marker1 = Marker(
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            markerId: MarkerId('staff Currnet location'),
            position: LatLng(staff1Location[0]['Location']?.latitude,
                staff1Location[0]['Location'].longitude),
            infoWindow: InfoWindow(
              title:
                  'Name: ${staff1Location[0]['Name']} (Department: ${staff1Location[0]['Category']})',
              snippet: ' Phone Number: ${staff1Location[0]['PhoneNumber']}',
            ),
          );
          Marker userLocationMarker = Marker(
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            markerId: const MarkerId('user Location'),
            position: LatLng(
                widget.userLocation.latitude, widget.userLocation.longitude),
            infoWindow: const InfoWindow(
              title: 'Requested Location',
            ),
          );
          markers.add(marker1);
          markers.add(userLocationMarker);

          return Scaffold(
              body: SizedBox(
            height: height,
            width: width,
            child: GoogleMap(
              mapType: MapType.normal,
              markers: Set<Marker>.of(markers),
              initialCameraPosition: CameraPosition(
                  target: LatLng(widget.userLocation.latitude,
                      widget.userLocation.longitude),
                  zoom: 12),
            ),
          ));
        });
  }
}
