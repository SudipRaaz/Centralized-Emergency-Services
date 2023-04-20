import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ems_project/Controller/authentication_functions.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:multiple_stream_builder/multiple_stream_builder.dart';

class MyMapTrack3 extends StatefulWidget {
  final GeoPoint userLocation;
  final String? ambulanceStaffID;
  final String? fireBrigadeStaffID;
  final String? policeStaffID;
  const MyMapTrack3(
      {super.key,
      required this.userLocation,
      this.ambulanceStaffID,
      this.fireBrigadeStaffID,
      this.policeStaffID});

  @override
  // ignore: library_private_types_in_public_api
  _MyMapTrack3State createState() => _MyMapTrack3State();
}

class _MyMapTrack3State extends State<MyMapTrack3> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // list of staff data
    List ambulanceLocation = [];
    List fireBrigadeLocation = [];
    List policeLocation = [];

    // markers
    List<Marker> markers = [];

    final Stream<QuerySnapshot> staff1 = FirebaseFirestore.instance
        .collection('Staffs')
        .where('UID', isEqualTo: widget.ambulanceStaffID)
        .snapshots();
    final Stream<QuerySnapshot> staff2 = FirebaseFirestore.instance
        .collection('Staffs')
        .where('UID', isEqualTo: widget.fireBrigadeStaffID)
        .snapshots();
    final Stream<QuerySnapshot> staff3 = FirebaseFirestore.instance
        .collection('Staffs')
        .where('UID', isEqualTo: widget.policeStaffID)
        .snapshots();

    return StreamBuilder3<QuerySnapshot, QuerySnapshot, QuerySnapshot>(
        streams: StreamTuple3(staff1, staff2, staff3),
        builder: (context, snapshots) {
          ambulanceLocation = [];
          fireBrigadeLocation = [];
          policeLocation = [];
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
          //circular progress indicator
          if (!snapshots.snapshot3.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // converting JSON to list
          snapshots.snapshot1.data!.docs.map((DocumentSnapshot document) {
            Map staffData = document.data() as Map<String, dynamic>;
            ambulanceLocation.add(staffData);
          }).toList();

          // converting JSON to list
          snapshots.snapshot2.data!.docs.map((DocumentSnapshot document) {
            Map productdata = document.data() as Map<String, dynamic>;
            fireBrigadeLocation.add(productdata);
          }).toList();

          // converting JSON to list
          snapshots.snapshot3.data!.docs.map((DocumentSnapshot document) {
            Map productdata = document.data() as Map<String, dynamic>;
            policeLocation.add(productdata);
          }).toList();

          // pointing markers
          Marker marker1 = Marker(
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            markerId: MarkerId('staff Currnet location'),
            position: LatLng(ambulanceLocation[0]['Location']?.latitude,
                ambulanceLocation[0]['Location'].longitude),
            infoWindow: InfoWindow(
              title:
                  'Name: ${ambulanceLocation[0]['Name']} (Department: ${ambulanceLocation[0]['Category']})',
              snippet: ' Phone Number: ${ambulanceLocation[0]['PhoneNumber']}',
            ),
          );
          Marker marker2 = Marker(
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
            markerId: MarkerId('fireBrigadeLocation'),
            position: LatLng(fireBrigadeLocation[0]['Location']?.latitude,
                fireBrigadeLocation[0]['Location'].longitude),
            infoWindow: InfoWindow(
              title:
                  'Name: ${fireBrigadeLocation[0]['Name']} (Department: ${fireBrigadeLocation[0]['Category']})',
              snippet:
                  ' Phone Number: ${fireBrigadeLocation[0]['PhoneNumber']}',
            ),
          );
          Marker marker3 = Marker(
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
            markerId: MarkerId('policeLocation'),
            position: LatLng(policeLocation[0]['Location']?.latitude,
                policeLocation[0]['Location'].longitude),
            infoWindow: InfoWindow(
              title:
                  'Name: ${policeLocation[0]['Name']}  (Department: ${policeLocation[0]['Category']})',
              snippet: ' Phone Number: ${policeLocation[0]['PhoneNumber']}',
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
          markers.add(marker3);
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
