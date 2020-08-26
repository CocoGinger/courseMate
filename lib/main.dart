import 'dart:async';
import 'package:CourseMate/logic/bloc.dart';
import 'package:CourseMate/logic/sharedPref_logic.dart';
import 'package:CourseMate/logic/theme_chooser.dart';
import 'package:CourseMate/pages/intro_page.dart';
import 'package:CourseMate/pages/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //Following code will Force the App Orientation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<int> _counter;

  //Colors for theme
  static Color lightPrimary = Color(0xfffcfcff);
  static Color darkPrimary = Color(0xff313131);
  static Color lightAccent = Colors.blue;
  static Color darkAccent = Colors.lightBlue;
  static Color lightBG = Color(0xfffcfcff);
  static Color darkBG = Color(0xff313131);

  @override
  void initState() {
    super.initState();
    //Initially loads Theme Color from SharedPreferences
    loadColor();
    _counter = _prefs.then((SharedPreferences prefs) {
      return (prefs.getInt('counter') ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return FutureBuilder<int>(
        future: _counter,
        builder: (BuildContext context, AsyncSnapshot<int> snap) {
          switch (snap.connectionState) {
            case ConnectionState.waiting:
              return MaterialApp(
                  home: Center(child: CircularProgressIndicator()));
            default:
              if (snap.hasError) {
                return MaterialApp(
                    home: Center(child: Text('Error: ${snap.error}')));
              } else {
                return snap.data != 1
                    ? StreamBuilder(
                        //This StreamBuilder will listen data about chosen theme color and
                        //change the UI acording to it.
                        //This Stream is triggered from custom_appbar.dart

                        stream: bloc.recieveColorName,
                        initialData: 'Yellow',
                        builder: (context, snapshot) {
                          return MaterialApp(
                            title: 'CourseMate',
                            debugShowCheckedModeBanner: false,
                            //Global ThemeData for the App
                            theme: ThemeData(
                              backgroundColor: lightBG,
                              primaryColor: lightPrimary,
                              accentColor: themeChooser(snapshot.data),
                              cursorColor: lightAccent,
                              scaffoldBackgroundColor: lightBG,
                              appBarTheme: AppBarTheme(
                                elevation: 0,
                                textTheme: TextTheme(
                                  headline1: TextStyle(
                                    color: darkBG,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                            darkTheme: ThemeData(
                              brightness: Brightness.dark,
                              backgroundColor: darkBG,
                              primaryColor: darkPrimary,
                              accentColor: themeChooser(snapshot.data),
                              scaffoldBackgroundColor: darkBG,
                              cursorColor: darkAccent,
                              appBarTheme: AppBarTheme(
                                elevation: 0,
                                textTheme: TextTheme(
                                  headline1: TextStyle(
                                    color: lightBG,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),

                            home: OnBoardingPage(),
                          );
                        })
                    : StreamBuilder<Object>(
                        //This StreamBuilder will listen data about chosen theme color and
                        //change the UI acording to it.
                        //This Stream is triggered from custom_appbar.dart

                        stream: bloc.recieveColorName,
                        initialData: 'Yellow',
                        builder: (context, snapshot) {
                          return MaterialApp(
                              title: 'CourseMate',
                              debugShowCheckedModeBanner: false,
                              //Global ThemeData for the App
                              theme: ThemeData(
                                backgroundColor: lightBG,
                                primaryColor: lightPrimary,
                                accentColor: themeChooser(snapshot.data),
                                cursorColor: lightAccent,
                                scaffoldBackgroundColor: lightBG,
                                appBarTheme: AppBarTheme(
                                  elevation: 0,
                                  textTheme: TextTheme(
                                    headline1: TextStyle(
                                      color: darkBG,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                              darkTheme: ThemeData(
                                brightness: Brightness.dark,
                                backgroundColor: darkBG,
                                primaryColor: darkPrimary,
                                accentColor: themeChooser(snapshot.data),
                                scaffoldBackgroundColor: darkBG,
                                cursorColor: darkAccent,
                                appBarTheme: AppBarTheme(
                                  elevation: 0,
                                  textTheme: TextTheme(
                                    headline1: TextStyle(
                                      color: lightBG,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                              themeMode: ThemeMode.dark,
                              home: MainScreen());
                        });
              }
          }
        });
  }
}
