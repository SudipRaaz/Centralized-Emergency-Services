import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ems_project/Controller/authentication_functions.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:multiple_stream_builder/multiple_stream_builder.dart';

class MyMapTrack2 extends StatefulWidget {
  final GeoPoint userLocation;
  final String? staffID1;
  final String? staffID2;
  const MyMapTrack2({
    super.key,
    required this.userLocation,
    this.staffID1,
    this.staffID2,
  });

  @override
  // ignore: library_private_types_in_public_api
  _MyMapTrack2State createState() => _MyMapTrack2State();
}

class _MyMapTrack2State extends State<MyMapTrack2> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // list of staff data
    List staff1Location = [];
    List staff2Location = [];

    // markers
    List<Marker> markers = [];

    final Stream<QuerySnapshot> staff1 = FirebaseFirestore.instance
        .collection('Staffs')
        .where('UID', isEqualTo: widget.staffID1)
        .snapshots();
    final Stream<QuerySnapshot> staff2 = FirebaseFirestore.instance
        .collection('Staffs')
        .where('UID', isEqualTo: widget.staffID2)
        .snapshots();

    return StreamBuilder2<QuerySnapshot, QuerySnapshot>(
        streams: StreamTuple2(staff1, staff2),
        builder: (context, snapshots) {
          staff1Location = [];
          staff2Location = [];
          //circular progress indicator
          if (!snapshots.snapshot1.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          //circular progress indicator
          if (!snapshots.snapshot2.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // converting JSON to list
          snapshots.snapshot1.data!.docs.map((DocumentSnapshot document) {
            Map staffData = document.data() as Map<String, dynamic>;
            staff1Location.add(staffData);
          }).toList();

          // converting JSON to list
          snapshots.snapshot2.data!.docs.map((DocumentSnapshot document) {
            Map productdata = document.data() as Map<String, dynamic>;
            staff2Location.add(productdata);
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
          Marker marker2 = Marker(
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
            markerId: const MarkerId('fireBrigadeLocation'),
            position: LatLng(staff2Location[0]['Location']?.latitude,
                staff2Location[0]['Location'].longitude),
            infoWindow: InfoWindow(
              title:
                  'Name: ${staff2Location[0]['Name']} (Department: ${staff2Location[0]['Category']})',
              snippet: ' Phone Number: ${staff2Location[0]['PhoneNumber']}',
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
          markers.add(marker2);
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
