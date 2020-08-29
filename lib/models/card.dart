import 'package:CourseMate/auth/authstate.dart';

AuthState _auth = AuthState();

class CardModel {
  String imagePath, followers, posts, following, name, location;
  bool isFollow;

  CardModel(
    this.imagePath,
    this.followers,
    this.posts,
    this.following,
    this.name,
    this.location,
    this.isFollow,
  );
}

final List<CardModel> cards = [
  CardModel(
    'assets/images/1.jpg',
    '869',
    '135',
    '437',
    _auth.user.name ?? '',
    _auth.user.email ?? '',
    false,
  ),
];
