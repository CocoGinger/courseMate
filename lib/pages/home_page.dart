import 'package:CourseMate/components/page_heading.dart';
import 'package:CourseMate/components/searchbar.dart';
import 'package:CourseMate/pages/imagepicker.dart';
import 'package:CourseMate/widgets/posts_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          heroTag: "btn1",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ImagePicker()),
            );
          },
          child: Icon(Icons.add),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
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
            )),
      ),
    );
  }
}
