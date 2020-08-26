import 'dart:async';

import 'package:CourseMate/components/custom_appbar.dart';
import 'package:CourseMate/components/dialog.dart';
import 'package:CourseMate/pages/home_page.dart';
import 'package:CourseMate/pages/imagepicker.dart';
import 'package:CourseMate/pages/userprofile.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController;
  int _page = 2;
   
  _MainScreenState();
var connectivityStatus = 'Unknown';

  //This is verify the Internet Access.
  Connectivity connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> connectivitySubs;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(75),

          //CustomAppBar is wrapped under Theme(), so that CustomAppBar's canvasColor can be transparent and not the whole app's.

          child: Theme(
            data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
            child: CustomAppBar(),
          ),
        ),
      body: PageView(
        physics: ClampingScrollPhysics(),
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: <Widget>[
         HomePage(),
         ImagePicker(),
         HomePage(),
         HomePage(),
         UserProfile()
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: Theme.of(context).primaryColor,
          // sets the active color of the `BottomNavigationBar` if `Brightness` is light
          primaryColor: Theme.of(context).accentColor,
          textTheme: Theme.of(context).textTheme.copyWith(
                caption: TextStyle(color: Colors.grey[500]),
              ),
        ),
        child: BottomNavigationBar(
          elevation: 4.0,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.message,
              ),
              title: Container(height: 0.0),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.group,
              ),
              title: Container(height: 0.0),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              title: Container(height: 0.0),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              title: Container(height: 0.0),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              title: Container(height: 0.0),
            ),
          ],
          onTap: navigationTapped,
          currentIndex: _page,
        ),
      ),
    );
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 2);
    connectivitySubs =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      connectivityStatus = result.toString();
      if (result == ConnectivityResult.none) {
        noInternetDialog(context);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
     connectivitySubs.cancel();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}
