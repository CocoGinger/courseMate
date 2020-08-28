import 'package:CourseMate/app.dart';
import 'package:CourseMate/auth/authstate.dart';
import 'package:CourseMate/logic/providers.dart';
import 'package:CourseMate/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //Following code will Force the App Orientation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(Intro());
}

class Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(home: Consumer<AuthState>(
        builder: (context, state, child) {
          return state.isLoggedIn ? App() : LoginPage();
        },
      )),
    );
  }
}
