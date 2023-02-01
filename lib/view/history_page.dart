import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.amber,
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  height: 300,
                  color: Colors.blueAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                            " Case ID: \n Date: Time: \n Requeseted Service : \n Message : \n Response Message : "),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: 5,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 8,
              );
            },
          )),
    );
  }
}
