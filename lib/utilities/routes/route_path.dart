import 'package:ems_project/page_layout.dart';
import 'package:ems_project/utilities/routes/routes.dart';
import 'package:ems_project/view/dashboard_page.dart';
import 'package:flutter/material.dart';
import '../../view/login_page.dart';
import '../../view/register_page.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    // route setting request cases
    switch (settings.name) {

      // case; requesting for login
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());

      case RoutesName.register:
        return MaterialPageRoute(
            builder: (BuildContext context) => const Register());

      case RoutesName.dashboard:
        return MaterialPageRoute(
            builder: (BuildContext context) => const DashboardPage());

      case RoutesName.pageLayout:
        return MaterialPageRoute(
            builder: (BuildContext context) => const PageLayout());

      // if non of these above cases are met then return this
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(child: Text("no route defined")),
          );
        });
    }
  }
}
