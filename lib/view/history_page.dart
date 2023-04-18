import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ems_project/Controller/authentication_functions.dart';
import 'package:ems_project/model/request_model.dart';
import 'package:ems_project/resource/components/buttons.dart';
import 'package:ems_project/resource/components/gardientButton.dart';
import 'package:ems_project/view/google_map.dart';
import 'package:ems_project/view/google_map_track1.dart';
import 'package:ems_project/view/google_map_track2.dart';
import 'package:ems_project/view/service_map_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../resource/constants/colors.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = Authentication().currentUser!.uid;
    final Stream<QuerySnapshot> _userHistory = FirebaseFirestore.instance
        .collection('CustomerRequests')
        .where('uid', isEqualTo: uid)
        .snapshots();

    // list
    List historyDocs;

    return StreamBuilder(
        stream: _userHistory,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text("Loading"));
          }

          //clearing the productsDocs list
          historyDocs = [];

          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map historyData = document.data() as Map<String, dynamic>;
            historyDocs.add(historyData);
          }).toList();

          return Scaffold(
            appBar: AppBar(
              title: const Text("History"),
              backgroundColor: AppColors.appBar_theme,
            ),
            body: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    // formating timestamp from firebase data
                    Timestamp timestamp = historyDocs[index]['requestedAt'];
                    DateTime dateTime = timestamp.toDate();
                    var requestService = '';
                    var serviceAlloted = '';
                    if (historyDocs[index]['ambulanceService']) {
                      requestService = '\n      Ambulance Service';
                    }
                    if (historyDocs[index]['fireBrigadeService']) {
                      requestService =
                          '$requestService\n      Fire Brigade Service';
                    }
                    if (historyDocs[index]['policeService']) {
                      requestService = '$requestService\n      Police Service';
                    }

                    // checking for service alloted
                    if (historyDocs[index]['ambulanceServiceAlloted']) {
                      serviceAlloted = '\n      Ambulance Service Alloted';
                    }
                    if (historyDocs[index]['fireBrigadeServiceAlloted']) {
                      serviceAlloted =
                          '$serviceAlloted\n       Fire Brigade Service Alloted';
                    }
                    if (historyDocs[index]['policeServiceAlloted']) {
                      serviceAlloted =
                          '$serviceAlloted\n       Police Service Alloted';
                    }

                    return Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '''
Status :  ${historyDocs[index]['Status']}
Case ID: ${historyDocs[index]['caseID']} 
Date: ${dateTime.year}/${dateTime.month}/${dateTime.day}        Time: ${dateTime.hour}:${dateTime.minute}:${dateTime.second} 
Requested Service :  $requestService
Message : ${historyDocs[index]['message']}
Response
$serviceAlloted
''',
                                style: const TextStyle(fontSize: 18),
                              ),
                              trackGeoLocation(context, historyDocs, index)
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: historyDocs.length,
                )),
          );
        });
  }

  Widget trackGeoLocation(
      BuildContext context, List<dynamic> historyDocs, int index) {
    if (historyDocs[index]['Status'] == 'In Progress') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MyGradientButton(
            text: "Track",
            onPress: () {
              if (historyDocs[index]['ambulanceServiceAlloted'] &&
                  historyDocs[index]['fireBrigadeServiceAlloted'] &&
                  historyDocs[index]['policeServiceAlloted']) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => MyMapTrack3(
                              userLocation: historyDocs[index]['userLocation'],
                              ambulanceStaffID: historyDocs[index]
                                  ['ambulanceAllotedID'],
                              fireBrigadeStaffID: historyDocs[index]
                                  ['fireBrigadeAllotedID'],
                              policeStaffID: historyDocs[index]
                                  ['policeAllotedID'],
                            )));
              }
              // double service requests tracking
              else if (historyDocs[index]['ambulanceServiceAlloted'] &&
                  historyDocs[index]['fireBrigadeServiceAlloted']) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => MyMapTrack2(
                              userLocation: historyDocs[index]['userLocation'],
                              staffID1: historyDocs[index]
                                  ['ambulanceAllotedID'],
                              staffID2: historyDocs[index]
                                  ['fireBrigadeAllotedID'],
                            )));
              } else if (historyDocs[index]['ambulanceServiceAlloted'] &&
                  historyDocs[index]['policeServiceAlloted']) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => MyMapTrack2(
                              userLocation: historyDocs[index]['userLocation'],
                              staffID1: historyDocs[index]
                                  ['ambulanceAllotedID'],
                              staffID2: historyDocs[index]['policeAllotedID'],
                            )));
              } else if (historyDocs[index]['fireBrigadeServiceAlloted'] &&
                  historyDocs[index]['policeServiceAlloted']) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => MyMapTrack2(
                              userLocation: historyDocs[index]['userLocation'],
                              staffID1: historyDocs[index]
                                  ['fireBrigadeAllotedID'],
                              staffID2: historyDocs[index]['policeAllotedID'],
                            )));
              }
              // single service requets tracking
              else if (historyDocs[index]['fireBrigadeServiceAlloted']) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => MyMapTrack1(
                              userLocation: historyDocs[index]['userLocation'],
                              staffID1: historyDocs[index]
                                  ['fireBrigadeAllotedID'],
                            )));
              } else if (historyDocs[index]['ambulanceServiceAlloted']
                  as bool) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => MyMapTrack1(
                              userLocation: historyDocs[index]['userLocation'],
                              staffID1: historyDocs[index]
                                  ['ambulanceAllotedID'],
                            )));
              } else if (historyDocs[index]['policeServiceAlloted']) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => MyMapTrack1(
                              userLocation: historyDocs[index]['userLocation'],
                              staffID1: historyDocs[index]['policeAllotedID'],
                            )));
              } else {
                log('did matched any of');
              }
            },
            iconData: Icons.location_on,
          )
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
