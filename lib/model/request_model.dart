import 'package:cloud_firestore/cloud_firestore.dart';

class RequestModel {
  // user ID
  String? uid;
  // requested service
  bool ambulanceService;
  bool fireBrigadeService;
  bool policeService;
  // message
  String message;
  // user location
  double latitude;
  double longitude;
  // timestamp
  DateTime requestedAt;
  DateTime? allotedAt;
  // service alloted ID
  String? ambulanceAllotedID;
  String? fireBrigadeAllotedID;
  String? policeAllotedID;
  // service alloted bool
  bool ambulanceServiceAlloted;
  bool fireBrigadeServiceAlloted;
  bool policeServiceAlloted;
  String? status;

  RequestModel(
      {
      // user ID
      this.uid,
      // requested service
      required this.ambulanceService,
      required this.fireBrigadeService,
      required this.policeService,
      // user's message
      required this.message,
      // user location
      required this.latitude,
      required this.longitude,
      // timestamp
      required this.requestedAt,
      this.allotedAt,
      // service alloted
      this.ambulanceAllotedID,
      this.fireBrigadeAllotedID,
      this.policeAllotedID,
      // service alloted bool
      this.ambulanceServiceAlloted = false,
      this.fireBrigadeServiceAlloted = false,
      this.policeServiceAlloted = false,
      this.status});

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
        uid: json["uid"] as String,
        ambulanceService: json["ambulanceService"],
        fireBrigadeService: json["fireBrigadeService"],
        policeService: json["policeService"],
        message: json["message"],
        latitude: json["latitude"] as double,
        longitude: json["longitude"] as double,
        requestedAt: json["requestedAt"],
        allotedAt: json["allotedAt"],
        ambulanceAllotedID: json["ambulanceAllotedID"],
        fireBrigadeAllotedID: json["fireBrigadeAllotedID"],
        policeAllotedID: json["policeAllotedID"],
        ambulanceServiceAlloted: json["ambulanceServiceAlloted"],
        fireBrigadeServiceAlloted: json["fireBrigadeServiceAlloted"],
        policeServiceAlloted: json["policeServiceAlloted"],
        status: json["Status"] as String);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'uid': uid,
        'ambulanceService': ambulanceService,
        'fireBrigadeService': fireBrigadeService,
        'policeService': policeService,
        'message': message,
        'latitude': latitude,
        'longitude': longitude,
        'requestedAt': requestedAt,
        'allotedAt': allotedAt,
        'ambulanceAllotedID': ambulanceAllotedID,
        'fireBrigadeAllotedID': fireBrigadeAllotedID,
        'policeAllotedID': policeAllotedID,
        'ambulanceServiceAlloted': ambulanceServiceAlloted,
        'fireBrigadeServiceAlloted': fireBrigadeServiceAlloted,
        'policeServiceAlloted': policeServiceAlloted,
        'Status': status
      };

  factory RequestModel.fromSnapshot(DocumentSnapshot snapshot) {
    final requested =
        RequestModel.fromJson(snapshot.data() as Map<String, dynamic>);
    return requested;
  }
}
