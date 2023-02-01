import 'package:ems_project/utilities/routes/route_path.dart';
import 'package:ems_project/utilities/routes/routes.dart';
import 'package:ems_project/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/tab_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TabManager()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // initial routing to splash screen
        initialRoute: RoutesName.login,
        // path to generating routes
        onGenerateRoute: Routes.generateRoutes,
      ),
    );
  }
}
