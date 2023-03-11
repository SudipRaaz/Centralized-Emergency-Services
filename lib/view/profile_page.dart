import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ems_project/Controller/authentication_functions.dart';
import 'package:ems_project/utilities/routes/routes.dart';
import 'package:flutter/material.dart';
import '../resource/constants/colors.dart';
import '../resource/constants/sized_box.dart';
import '../utilities/InfoDisplay/dialogbox.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userID = Authentication().currentUser!.uid;
    final _userProfile =
        FirebaseFirestore.instance.collection('Users').doc(userID).get();
    List userDocs;
    return FutureBuilder(
        future: _userProfile,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Error: " + snapshot.hasError.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          if (snapshot.connectionState == ConnectionState.none) {
            return Text("Error: " + snapshot.error.toString());
          }
          //clearing the productsDocs list
          userDocs = [];
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Profile'),
              backgroundColor: AppColors.appBar_theme,
            ),
            body: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    addVerticalSpace(20),
                    const CircleAvatar(
                      radius: 50,
                    ),
                    addVerticalSpace(20),
                    // Text("Name: ${userDocs[0]['name']}"),
                    Text("Name: ${data['Name']}"),
                    addVerticalSpace(60),
                    _featureTiles(
                      text: 'Feedback',
                      onPress: () {
                        return ShowDialog().showFeedbackForm(context, () {});
                      },
                    ),
                    _featureTiles(
                      text: 'User Guide',
                      onPress: () {
                        Navigator.pushNamed(context, RoutesName.userGuide);
                      },
                    ),
                    _featureTiles(
                      text: 'Report Bug',
                      onPress: () {
                        ShowDialog().reportBug(context, () {});
                      },
                    ),
                    _featureTiles(
                      text: 'Log Out',
                      onPress: () {},
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}

class _featureTiles extends StatelessWidget {
  String text;
  VoidCallback onPress;
  _featureTiles({required this.text, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: onPress,
        child: ListTile(
          selectedTileColor: Colors.indigo,
          tileColor: Colors.blueAccent,
          selected: true,
          title: Text(
            text,
            style: const TextStyle(fontSize: 22, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
