import 'dart:ui';

import 'package:CourseMate/auth/authstate.dart';
import 'package:CourseMate/models/card.dart';
import 'package:CourseMate/pages/settings_page.dart';
import 'package:CourseMate/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile>
    with TickerProviderStateMixin {
  double percentSlide = 1.0;

  int cardIndex = 0;

  double scrollPercent = 0.0;
  double cardPercent = 0.0;
  Offset startDrag;
  double startDragPercentScroll;
  double singleCardStart;
  double singleCardEnd;
  AnimationController singleCardFinish,
      followCtrl,
      scaleCtrl,
      openUserCtrl,
      userInfoCtrl,
      zoomCtrl;
  Animation followAnim, scaleAnim, openUserAnim, userInfoAnim, zoomAnim;

  @override
  void initState() {
    super.initState();
    singleCardFinish = AnimationController(
      duration: Duration(milliseconds: 150),
      vsync: this,
    )..addListener(() {
        setState(() {
          scrollPercent = lerpDouble(
              singleCardStart, singleCardEnd, singleCardFinish.value);
        });
      });

    followCtrl = AnimationController(
      duration: Duration(milliseconds: 350),
      vsync: this,
    );

    followAnim = Tween(begin: 46.0, end: 100.0).animate(followCtrl)
      ..addListener(() {
        setState(() {});
      });

    scaleCtrl = AnimationController(
      duration: Duration(milliseconds: 100),
      vsync: this,
    );

    scaleAnim = Tween(begin: 1.0, end: 0.0).animate(scaleCtrl)
      ..addListener(() {
        setState(() {});
      });

    userInfoCtrl = AnimationController(
      duration: Duration(milliseconds: 280),
      vsync: this,
    );

    userInfoAnim = Tween(begin: 0.0, end: 1.0).animate(userInfoCtrl)
      ..addListener(() {
        setState(() {});
      });

    zoomCtrl = AnimationController(
      duration: Duration(milliseconds: 280),
      vsync: this,
    );

    zoomAnim = Tween(begin: 1.1, end: 1.0).animate(zoomCtrl)
      ..addListener(() {
        setState(() {});
      });

    openUserCtrl = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    openUserAnim = Tween(begin: 290.0, end: 540.0).animate(openUserCtrl)
      ..addListener(() {
        setState(() {});
      });

    followCtrl.forward();
    scaleCtrl.forward();
    openUserCtrl.forward();
  }

  @override
  void dispose() {
    singleCardFinish.dispose();
    followCtrl.dispose();
    scaleCtrl.dispose();
    openUserCtrl.dispose();
    super.dispose();
  }

  Widget _buildCard(scrollPercent) {
    final cardScrollPercent = scrollPercent / (1 / 1);
    return FractionalTranslation(
      translation: Offset(0 - cardScrollPercent,
          0.0), //MediaQuery.of(context).size.width * cardId
      child: Transform(
        transform: Matrix4.translationValues(0.0, 0.0, 0.0)
          ..scale(zoomAnim.value),
        child: Card(
          imgPath: 'assets/images/2.jpg',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthState>(builder: (context, state, child) {
        return Stack(
          fit: StackFit.expand,
          children: [
            Stack(
              overflow: Overflow.clip,
              children: [_buildCard(scrollPercent)],
            ),
            Transform(
              transform:
                  Matrix4.translationValues(0.0, openUserAnim.value, 0.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 10.0,
                    ),
                    child: Opacity(
                      opacity: percentSlide,
                      child: Transform(
                        transform: Matrix4.translationValues(
                            0.0, 44.0 * (1.0 - percentSlide), 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: Text(
                                    "23",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                                Text(
                                  'followers',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14.0),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: Text(
                                    "456",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                                Text(
                                  'posts',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14.0),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: Text(
                                    "45",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                                Text(
                                  'following',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 400.0,
                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 30.0),
                          child: Opacity(
                            opacity: percentSlide,
                            child: Transform(
                              transform: Matrix4.translationValues(
                                  0.0, 44.0 * (1.0 - percentSlide), 0.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {},
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          state.user.name,
                                          style: TextStyle(
                                            // color: Colors.black,
                                            fontSize: 20.0,
                                          ),
                                        ),
                                        Text(
                                          state.user.email,
                                        ),
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    padding: const EdgeInsets.all(0.0),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  SettingsScreen()));
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: followAnim.value,
                                      height: 46.0,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).accentColor,
                                          borderRadius:
                                              BorderRadius.circular(50.0)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: <Widget>[
                                            Transform(
                                              alignment: Alignment.center,
                                              transform: Matrix4
                                                  .translationValues(
                                                      0.0, 0.0, 0.0)
                                                ..scale(1.0 - scaleAnim.value),
                                              child: Opacity(
                                                opacity: 1.0 - scaleAnim.value,
                                                child: Text(
                                                  'Settings',
                                                  style: TextStyle(
                                                    letterSpacing: 1.0,
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Transform(
                                              alignment: Alignment.center,
                                              transform:
                                                  Matrix4.translationValues(
                                                      0.0, 0.0, 0.0)
                                                    ..scale(scaleAnim.value),
                                              child: Opacity(
                                                opacity: scaleAnim.value,
                                                child: Icon(
                                                    Icons.person_outline,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Opacity(
                          opacity: userInfoAnim.value,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0),
                                child: Text(
                                  'The widget has a very nifty feature which allows a Floating Action Button to be docked in it. Adding BottomAppBar in Scaffold.',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 30.0,
                                  vertical: 30.0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12.0),
                                      child: Text(
                                        'Photos',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.1,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      physics: const BouncingScrollPhysics(),
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Container(
                                              width: 160.0,
                                              height: 120.0,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/p1.jpg'),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Container(
                                              width: 160.0,
                                              height: 120.0,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/p2.jpg'),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Container(
                                              width: 160.0,
                                              height: 120.0,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/p3.jpg'),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Container(
                                              width: 160.0,
                                              height: 120.0,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/p4.jpg'),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Container(
                                              width: 160.0,
                                              height: 120.0,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/p5.jpg'),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

class Card extends StatelessWidget {
  final String imgPath;
  final bool isFollow;

  Card({this.imgPath, this.isFollow = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imgPath),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black26, BlendMode.multiply),
        ),
      ),
    );
  }
}
