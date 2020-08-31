import 'package:CourseMate/startup.dart';
import 'package:CourseMate/logic/bloc.dart';
import 'package:CourseMate/logic/sharedPref_logic.dart';
import 'package:CourseMate/logic/theme_chooser.dart';
import 'package:CourseMate/managers/dialog_manager.dart';
import 'package:CourseMate/services/analytics_service.dart';
import 'package:CourseMate/services/dialog_service.dart';
import 'package:CourseMate/services/navigation_service.dart';
import 'package:CourseMate/utils/locator.dart';
import 'package:CourseMate/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Following code will Force the App Orientation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  //Status Bar to always be transparent
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );
  
  // //Hide the Android navigation bar
  // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  
  
  // Register all the models and services before the app starts
  await setupLocator();

  runApp(Intro());
}

class Intro extends StatefulWidget {
  //Colors for theme
  static Color lightPrimary = Color(0xfffcfcff);
  static Color darkPrimary = Color(0xff313131);
  static Color lightAccent = Colors.blue;
  static Color darkAccent = Colors.lightBlue;
  static Color lightBG = Color(0xfffcfcff);
  static Color darkBG = Colors.black;

  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
   @override
  void initState() {
    super.initState();
    //Initially loads Theme Color from SharedPreferences
    loadColor();
   
  }
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: bloc.recieveColorName,
        initialData: 'Yellow',
        builder: (context, snapshot) {
          return MaterialApp(
              title: 'CourseMate',
              theme: ThemeData(
                backgroundColor: Intro.lightBG,
                primaryColor: Intro.lightPrimary,
                accentColor: themeChooser(snapshot.data),
                cursorColor: Intro.lightAccent,
                scaffoldBackgroundColor: Intro.lightBG,
                canvasColor: Colors.white,
                appBarTheme: AppBarTheme(
                  elevation: 0,
                  textTheme: TextTheme(
                    headline1: TextStyle(
                      color: Intro.darkBG,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                backgroundColor: Intro.darkBG,
                primaryColor: Intro.darkPrimary,
                accentColor: themeChooser(snapshot.data),
                scaffoldBackgroundColor: Intro.darkBG,
                cursorColor: Intro.darkAccent,
                canvasColor: Colors.black,
                appBarTheme: AppBarTheme(
                  elevation: 0,
                  textTheme: TextTheme(
                    headline1: TextStyle(
                      color: Intro.lightBG,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              builder: (context, child) => Navigator(
                    key: locator<DialogService>().dialogNavigationKey,
                    onGenerateRoute: (settings) => MaterialPageRoute(
                        builder: (context) => DialogManager(child: child)),
                  ),
              navigatorKey: locator<NavigationService>().navigationKey,
              navigatorObservers: [
                locator<AnalyticsService>().getAnalyticsObserver()
              ],
              onGenerateRoute: generateRoute,
              home: StartUpView());
        });
  }
}
