import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../resource/constants/colors.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Centralized Emergency Services '),
          backgroundColor: AppColors.appBar_theme,
        ),
        body: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
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
                        child: Text('Enable'),
                        style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            backgroundColor: AppColors.button_color,
                            foregroundColor: AppColors.blackColor),
                      )
                    ],
                  ),
                ),
              ),
              // tile lists
              SizedBox(
                height: 450,
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 3,
                    ),
                    itemCount: 9,
                    itemBuilder: (BuildContext ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.2,
                          height: 200,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(95, 201, 201, 201),
                              border: Border.all(
                                color: Colors.red,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Names"),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        )
        // bottomNavigationBar: ,
        );
  }
}
