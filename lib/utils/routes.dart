import 'package:CourseMate/app.dart';
import 'package:CourseMate/pages/login_page.dart';
import 'package:CourseMate/pages/settings_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String login = "login";
  static const String home = "home";
  static const String settingsPage = "settings";

  static Route<dynamic> onGenereateRoute(RouteSettings settings) {
    return MaterialPageRoute(
        settings: settings,
        builder: (context) {
          switch (settings.name) {
            case home:
              return App();
            case settingsPage:
              return SettingsScreen();
            case login:
            default:
              return LoginPage();
          }
        });
  }
}
