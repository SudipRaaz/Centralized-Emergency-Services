import 'package:ems_project/utilities/routes/routes.dart';
import 'package:ems_project/view/user_guide_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../resource/constants/sized_box.dart';
import '../utilities/InfoDisplay/dialogbox.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
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
              const Text("Name: Sudip Raj Adhikari"),
              addVerticalSpace(60),
              _featureTiles(
                  text: 'Change Password',
                  onPress: () => ShowDialog().changeMyPassowrd(context, () {})),
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
