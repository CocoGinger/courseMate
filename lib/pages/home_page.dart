import 'package:CourseMate/components/page_heading.dart';
import 'package:CourseMate/components/searchbar.dart';
import 'package:CourseMate/pages/imagepicker.dart';
import 'package:CourseMate/widgets/posts_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController;

  // ignore: unused_field
  int _page = 0;

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PageView(
          physics: BouncingScrollPhysics(),
          controller: _pageController,
          onPageChanged: onPageChanged,
          children: [Posts(), ImagePicker()],
        ),
      ),
    ));
  }
}

class Posts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 0),
      children: [
        pageHeader('Explore', 30),
        SizedBox(height: 20),
        Container(
          //SearchBar
          child: SearchBar(),
          padding: EdgeInsets.symmetric(horizontal: 30),
        ),
        SizedBox(height: 20),
        PostWidget(
            image:
                "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/allbikes-1539286251.jpg"),
        PostWidget(
            image:
                "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/allbikes-1539286251.jpg"),
        PostWidget(
            image:
                "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/allbikes-1539286251.jpg"),
        PostWidget(
            image:
                "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/allbikes-1539286251.jpg"),
      ],
    );
  }
}
