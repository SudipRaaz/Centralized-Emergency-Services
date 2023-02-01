import 'package:ems_project/view/dashboard_page.dart';
import 'package:ems_project/view/history_page.dart';
import 'package:ems_project/view/profile_page.dart';
import 'package:flutter/cupertino.dart';

class PageLists {
  static const List pages = <Widget>[
    DashboardPage(),
    HistoryPage(),
    ProfilePage()
  ];
}
