import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../components/page_heading.dart';

class UserProfile extends StatelessWidget {
  final Firestore adminFSI = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          pageHeader('About Me', 0),
          SizedBox(height: 20),
          StreamBuilder(
            stream: adminFSI.collection('admin').snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 30,
                      height: 240,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        image: DecorationImage(
                          //The following condition assures that when the internet is not connected,
                          //the Stream builder doesn't throw an error about list.length == 0.
                          image: (snapshot.data.documents.length > 0)
                              ? NetworkImage(
                                  snapshot.data.documents[0]['adminPic'])
                              : AssetImage('assets/images/idle_grey.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      left: 6.0,
                      child: InkWell(
                        onTap: () {
                          print("tapppp");
                        },
                        child: Center(
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              height: 7,
                              width: 7,
                              child: Icon(Icons.add_a_photo,
                                  color: Theme.of(context).accentColor)),
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
          SizedBox(height: 30),
          ListTile(
            leading: CircleAvatar(
              radius: 40,
            ),
            title: Text('Hello, CourseMate'),
            subtitle: Text(
                "This is Akash, I am a Badass Graphics Designer with 10 years of experience & now turned into a Developer. Flutter to be precise. Wanna know more, Check below."),
          ),
          SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FlatButton(
                child: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                color: Colors.grey,
                onPressed: () {},
              ),
              SizedBox(width: 20),
              FlatButton(
                child: Icon(
                  Icons.account_box,
                  color: Colors.white,
                ),
                color: Theme.of(context).accentColor,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
