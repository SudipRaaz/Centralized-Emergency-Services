import 'package:ems_project/Controller/authentication_base.dart';
import 'package:ems_project/Controller/authentication_functions.dart';
import 'package:ems_project/resource/constants/constant_values.dart';
import 'package:ems_project/utilities/InfoDisplay/dialogbox.dart';
import 'package:flutter/material.dart';

import '../resource/constants/colors.dart';
import '../resource/constants/sized_box.dart';
import '../resource/constants/style.dart';
import '../utilities/InfoDisplay/multipleRequest.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  TextEditingController requestService = TextEditingController();
  bool checkAmbulance = false;
  bool checkFireBrigade = false;
  bool checkPolice = false;

  @override
  Widget build(BuildContext context) {
    // setting available height and width
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Centralized Emergency Services '),
          backgroundColor: AppColors.appBar_theme,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  AuthenticationBase auth = Authentication();
                  auth.signOut();
                },
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: AppColors.button_color,
                    foregroundColor: AppColors.blackColor),
                child: const Text('log Out'),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 100,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Panic Mode "),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            backgroundColor: AppColors.button_color,
                            foregroundColor: AppColors.blackColor),
                        child: const Text('Enable'),
                      ),
                    ],
                  ),
                ),
              ),

              // tile lists
              SizedBox(
                height: height,
                width: width,
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 3,
                    ),
                    itemCount: EmergencyServices.servicesTiles.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return DashboardTile(
                        onPress: () {
                          setState(() {
                            if (index == 3) {
                              ShowDialog().showInformationDialog(context);
                            } else {
                              ShowDialog().requestService(context, () {});
                            }
                          });
                        },
                        index: index,
                      );
                    }),
              ),
            ],
          ),
        ));
  }
}

class DashboardTile extends StatelessWidget {
  final VoidCallback onPress;
  final int index;
  const DashboardTile({super.key, required this.onPress, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(95, 201, 201, 201),
              border: Border.all(
                color: Colors.red,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(EmergencyServices.servicesTiles[index]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
