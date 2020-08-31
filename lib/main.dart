import 'package:CourseMate/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //Following code will Force the App Orientation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(Intro());
}

class Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(home: App()
    );
  }
}
